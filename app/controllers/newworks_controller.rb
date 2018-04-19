class NewworksController < ApplicationController

  before_action :set_newwork, only: [:show, :edit, :update, :destroy, :worklian, :sett]
  def index
    @newworks = Newwork.where('isnew = 0')
    if params[:searchordernumber].to_s != ''
      @newworks = @newworks.where('ordernumber like ?',"%#{params[:searchordernumber]}%")
    end
    if params[:searchstartdate].to_s != ''
      @newworks = @newworks.where('created_at >= ?',"#{params[:searchstartdate]}")
    end
    if params[:searchenddate].to_s != ''
      @newworks = @newworks.where('created_at <= ?',"#{params[:searchenddate]}")
    end
    if params[:searchcustomer].to_s != ''
      customer = Customer.where('name like ?',"%#{params[:searchcustomer]}%")
      @newworks = @newworks.where('customer_id in (?)',customer.ids)
    end
    if params[:searchtel].to_s != ''
      customer = Customer.where('tel like ?',"%#{params[:searchtel]}%")
      @newworks = @newworks.where('customer_id in (?)',customer.ids)
    end
    if params[:searchcooper].to_s != ''
      cooper = Cooper.where('name like ?',"%#{params[:searchcooper]}%")
      @newworks = @newworks.where('cooper_id in (?)',cooper.ids)
    end
    if params[:searchdesigner].to_s != ''
      designer = Designer.where('name like ?',"%#{params[:searchdesigner]}%")
      @newworks = @newworks.where('designer_id in (?)',designer.ids)
    end
    if params[:searchfiter].to_s != ''
      fiter = Fiter.where('name like ?',"%#{params[:searchfiter]}%")
      @newworks = @newworks.where('fiter_id in (?)',fiter.ids)
    end
    @newworks = @newworks.paginate(:page => params[:page], :per_page => 20)
  end

  def edit
    @coopers = Cooper.all
    @customers = Customer.all
    @users = User.all
    @designers = Designer.all
    @fiters = Fiter.all
    @preraws = Preraw.all
    @users = User.all
  end

  def new
    ordernumber = Prefixorder.first.work + Time.now.strftime('%Y%m%d')
    smnumber = Newwork.last
    mystep ='001'
    if smnumber
      if smnumber.ordernumber[-14..-4] == ordernumber[-11..-1]
        mystep=smnumber.ordernumber[-3..-1]
        mystep = (mystep.to_i+1).to_s
        (3-mystep.length).times do
          mystep = '0' + mystep
        end
        ordernumber += mystep
      else
        ordernumber += mystep
      end
    else
      ordernumber += mystep
    end
    @inrawdepot = Newwork.create(ordernumber:ordernumber,isnew:1)
    redirect_to edit_newwork_path(@inrawdepot)
  end

  def create
    @preorder = Newwork.new(newwork_params)
    respond_to do |format|

      if @newwork.save
        format.html { redirect_to newworks_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @newwork.update(newwork_params)
        @newwork.isnew = 0
        @newwork.save
        @newworkdetails = @newwork.newworkdetails
        @newworkdetails.each do |f|
          newdepot = Newdepot.where('newraw_id = ?',f.newraw_id).first

          if newdepot
            newdepot.number -= f.width / 1000 * f.height / 1000 * f.number
            newdepot.save
          end
          workdepot = Workdepot.where('newraw_id = ?',f.newraw_id).first
          if workdepot
            workdepot.number +=f.width / 1000 * f.height / 1000 * f.number
            workdepot.save
          else
            Workdepot.create(number:f.width / 1000 * f.height / 1000 * f.number,newraw_id:f.newraw_id)
          end
          Workrecord.create(worknumber:@newwork.ordernumber,newwork_id:@newwork.id,newraw_id:f.newraw_id,number:f.width / 1000 * f.height / 1000 * f.number)
        end


        format.html { redirect_to newworks_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @newwork }
      else
        format.html { render :edit }
        format.json { render json: @newwork.errors, status: :unprocessable_entity }
      end
    end
  end

  def worklian
    @coopers = Cooper.all
  end

  def sett
    @coopers = Cooper.all
    @newworkdetails = Newwork.find(params[:id]).newworkdetails.order("width desc, height desc")
    @newworkdetailarr = Array.new
    @newworkdetails.each do |f|
      newworkdetailcla = Newworkdetailclass.new
      newworkdetailcla.id = f.id
      newworkdetailcla.name = f.newraw.name
      newworkdetailcla.price = f.newraw.price
      newworkdetailcla.width = f.width
      newworkdetailcla.height = f.height
      newworkdetailcla.userheight = f.userheight
      newworkdetailcla.number = f.number
      newworkdetailcla.sum = (f.newraw.price).to_f * f.number
      newworkdetailcla.widthtype = f.widthtype
      newworkdetailcla.heighttype = f.heighttype
      newworkdetailcla.lossarea = f.lossarea
      @newworkdetailarr.push newworkdetailcla
    end

  end


  def destroy
    @newwork.destroy
    respond_to do |format|
      format.html { redirect_to newworks_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  class Newworkdetailclass
    attr :id,true
    attr :newrawid,true
    attr :name,true
    attr :width,true
    attr :height,true
    attr :userheight,true
    attr :number,true
    attr :widthtype,true
    attr :heighttype,true
    attr :lossarea,true
    attr :price,true
    attr :sum,true
    attr :area,true
    attr :content,true
    attr :group,true
    attr :groupcolor,true
  end

  class Shapeclass
    # this.name ='';
    # this.x1 = 0.0;
    # this.x2 = 0.0;
    # this.y1 = 0.0;
    # this.y2 = 0.0;
    # this.cpx = 0.0;
    # this.cpy = 0.0;
    # this.width = 0.0;
    # this.height = 0.0;
    # this.x = 0.0;
    # this.y = 0.0;
    # this.cx = 0.0;
    # this.cy = 0.0;
    # this.rx = 0.0;
    # this.ry = 0.0;
    # this.cpx1 = 0.0;
    # this.cpy1 = 0.0;
    # this.text = '';
    attr :name,true
    attr :x1,true
    attr :x2,true
    attr :y1,true
    attr :y2,true
    attr :cpx,true
    attr :cpy,true
    attr :width,true
    attr :height,true
    attr :x,true
    attr :y,true
    attr :cx,true
    attr :cy,true
    attr :rx,true
    attr :ry,true
    attr :cpx1,true
    attr :cpy1,true
    attr :text,true
    attr :newworkdetailid,true
    attr :cwidth,true
    attr :cheight,true
  end

  def getdata
    @newworkdetails = Newwork.find(params[:newworkid]).newworkdetails.order("width desc, height desc")
    newworkdetailarr = Array.new
    shapearr = Array.new
    @newworkdetails.each do |f|
      newworkdetailcla = Newworkdetailclass.new
      newworkdetailcla.id = f.id
      newworkdetailcla.name = f.newraw.name
      newworkdetailcla.price = f.newraw.price
      newworkdetailcla.width = f.width
      newworkdetailcla.height = f.height
      newworkdetailcla.userheight = f.userheight
      newworkdetailcla.number = f.number
      newworkdetailcla.sum = (f.newraw.price).to_f * f.number
      newworkdetailcla.widthtype = f.widthtype
      newworkdetailcla.heighttype = f.heighttype
      newworkdetailcla.lossarea = f.lossarea
      newworkdetailcla.area = f.area
      newworkdetailcla.group = f.group
      if f.group.to_s.length > 0
        #newworkdetailcla.groupcolor = Colorlib.find_by_serial(f.group[-1,1]).color
      end
      newworkdetailarr.push newworkdetailcla

      shapes = f.shapes
if shapes.count >1
      shapes.each do |shape|
        shapecla = Shapeclass.new
        shapecla.name = shape.name
        shapecla.x1 = shape.x1
        shapecla.x2 = shape.x2
        shapecla.y1 = shape.y1
        shapecla.y2 = shape.y2
        shapecla.cpx = shape.cpx
        shapecla.cpy = shape.cpy
        shapecla.width = shape.width
        shapecla.height = shape.height
        shapecla.x = shape.x
        shapecla.y = shape.y
        shapecla.cx = shape.cx
        shapecla.cy = shape.cy
        shapecla.rx = shape.rx
        shapecla.ry = shape.ry
        shapecla.cpx1 = shape.cpx1
        shapecla.cpy1 = shape.cpy1
        shapecla.text = shape.text
        shapecla.newworkdetailid = shape.newworkdetail_id
        shapecla.cwidth = shape.cwidth
        shapecla.cheight = shape.cheight
        shapearr.push shapecla
      end
end

    end

    render json: '{"newworkdetail":' + newworkdetailarr.to_json + ',"shape":'+shapearr.to_json+'}'
  end

  def saveshape
    shapes = Shape.where('newworkdetail_id = ?',params[:newworkdetailid])
    shapes.each do |f|
      f.destroy
    end
    step = 0
    while params[:shape][step.to_s]
      Shape.create(newworkdetail_id:params[:newworkdetailid],
                   name:params[:shape][step.to_s]['name'],
                   x1:params[:shape][step.to_s]['x1'],
                   x2:params[:shape][step.to_s]['x2'],
                   y1:params[:shape][step.to_s]['y1'],
                   y2:params[:shape][step.to_s]['y2'],
                   cpx:params[:shape][step.to_s]['cpx'],
                   cpy:params[:shape][step.to_s]['cpy'],
                   width:params[:shape][step.to_s]['width'],
                   height:params[:shape][step.to_s]['height'],
                   x:params[:shape][step.to_s]['x'],
                   y:params[:shape][step.to_s]['y'],
                   cx:params[:shape][step.to_s]['cx'],
                   cy:params[:shape][step.to_s]['cy'],
                   rx:params[:shape][step.to_s]['rx'],
                   ry:params[:shape][step.to_s]['ry'],
                   cpx1:params[:shape][step.to_s]['cpx1'],
                   cpy1:params[:shape][step.to_s]['cpy1'],
                   text:params[:shape][step.to_s]['text'],
                   cwidth:params[:cwidth],
                   cheight:params[:cheight],
      )
      step += 1
    end
  end

  class Totalclass
    attr :name,true
    attr :number,true
    attr :unit,true
    attr :toalnumber,true
  end

  def gettotal
    rawarr = Array.new
    @newwork = Newwork.find(params[:newworkid])
    @newworkdetails = Newwork.find(params[:newworkid]).newworkdetails
    @newworkdetails.each do |f|
      rawarr.push f.newraw.id
    end
    rawarr.uniq!
    worktotalarr = Array.new
    usertotalarr = Array.new
    ##计算加工平方
    rawarr.each do |raw|
      totalcla = Totalclass.new
      totalcla.name = Newraw.find(raw).name
      totalcla.number = 0
      totalcla.unit = '平方'
      totalcla.toalnumber = 0

      usertotalcla = Totalclass.new
      usertotalcla.name = Newraw.find(raw).name
      usertotalcla.number = 0
      usertotalcla.unit = '平方'
      usertotalcla.toalnumber =0

      @newworkdetails.each do |f|
        if f.newraw_id == raw
          totalcla.number += (f.width / 1000) * (f.height / 1000) * f.number
          usertotalcla.number += (f.width / 1000) * (f.userheight.to_f / 1000) *f.number + f.lossarea.to_f
          totalcla.toalnumber += f.number
          usertotalcla.toalnumber += f.number
        end
      end
      worktotalarr.push totalcla
      usertotalarr.push usertotalcla
    end

    ##计算加工边长
    widthtypearr = Array.new
    heighttypearr = Array.new
    @newworkdetails = Newwork.find(params[:newworkid]).newworkdetails
    @newworkdetails.each do |f|
      widthtypearr.push f.widthtype
      widthtypearr.push f.heighttype
    end
    widthtypearr.uniq!


    lomacla = Totalclass.new
    xiaoyuancla = Totalclass.new
    userlomacla = Totalclass.new
    userxiaoyuancla = Totalclass.new
    lomacla.name = ''
    if @newwork.line && @newwork.line != 0
      lomacla.name = Preraw.find(@newwork.line).name
    end
    xiaoyuancla.name = ''
    if @newwork.wave && @newwork.wave != 0
      xiaoyuancla.name = Preraw.find(@newwork.wave).name
    end
    lomacla.number = 0
    xiaoyuancla.number = 0
    lomacla.unit = 'm'
    xiaoyuancla.unit = 'm'

    userlomacla.name = ''
    if @newwork.line && @newwork.line != 0
      userlomacla.name = Preraw.find(@newwork.line).name
    end
    userxiaoyuancla.name = ''
    if @newwork.wave && @newwork.wave != 0
      userxiaoyuancla.name = Preraw.find(@newwork.wave).name
    end
    userlomacla.number = 0
    userxiaoyuancla.number = 0
    userlomacla.unit = 'm'
    userxiaoyuancla.unit = 'm'

    @newworkdetails.each do |f|
      if f.widthtype == '02' || f.widthtype == '06'
        lomacla.number += f.width / 1000 * f.number
        userlomacla.number += f.width / 1000 * f.number
      end
      if f.heighttype == '02' || f.heighttype == '06'
        lomacla.number += f.height / 1000 * f.number
        userlomacla.number += f.height.to_f / 1000 * f.number
      end
      if f.widthtype == '03'
        lomacla.number += (f.width / 1000) * 2 * f.number
        userlomacla.number += (f.width / 1000) * 2 * f.number
      end
      if f.heighttype == '03'
        lomacla.number += (f.height / 1000) * 2 * f.number
        userlomacla.number += (f.height.to_f / 1000) * 2 * f.number
      end

      if f.widthtype == '04' || f.widthtype == '06'
        xiaoyuancla.number += f.width / 1000 * f.number
        userxiaoyuancla.number += f.width / 1000 * f.number
      end
      if f.heighttype == '04' || f.heighttype == '06'
        xiaoyuancla.number += f.height / 1000 * f.number
        userxiaoyuancla.number += f.height.to_f / 1000 * f.number
      end
      if f.widthtype == '05'
        xiaoyuancla.number += (f.width / 1000) * 2 * f.number
        userxiaoyuancla.number += (f.width / 1000) * 2 * f.number
      end
      if f.heighttype == '05'
        xiaoyuancla.number += (f.height / 1000) * 2 * f.number
        userxiaoyuancla.number += (f.height.to_f / 1000) * 2 * f.number
      end

    end
    if lomacla.number > 0
      worktotalarr.push lomacla
    end
    if xiaoyuancla.number > 0
      worktotalarr.push xiaoyuancla
    end
    if userlomacla.number > 0
      usertotalarr.push userlomacla
    end
    if userxiaoyuancla.number > 0
      usertotalarr.push userxiaoyuancla
    end






    render json: '{"work":' + worktotalarr.to_json + ',"user":'+usertotalarr.to_json+'}'
  end

  class Supplierclass
    attr :id,true
    attr :pinyin,true
    attr :name,true
  end

  def getsupplier
    suppliers = Supplier.all
    supplierarr = Array.new
    suppliers.each do |f|
      suppliercla = Supplierclass.new
      suppliercla.id = f.id
      suppliercla.pinyin = f.pinyin
      suppliercla.name = f.name
      supplierarr.push suppliercla
    end
    render json:supplierarr
  end

  class Prerawclass
    attr :id,true
    attr :pinyin,true
    attr :name,true
  end

  def getpreraw
    preraws = Newdepot.all
    prerawarr = Array.new
    preraws.each do |f|

      #newrawdetails = f.newdepotdetails

      prerawcla = Prerawclass.new
      prerawcla.id = f.id
      #prerawcla.pinyin = Newraw.find(f.newraw_id).pinyin

      prerawcla.name = Newraw.find(f.newraw_id).name
      prerawarr.push prerawcla

    end
    render json:prerawarr
  end



  def getrawbyid
    raw = Newraw.find(params[:id])

    render json:raw
  end

  def changenewworkdetail
    newwork=Newwork.find(params[:newworkid])
    if params[:line].to_s != ''
      newwork.line = params[:line]
    end
    if params[:wave].to_s != ''
      newwork.wave = params[:wave]
    end
    newwork.save

    if params[:way] =='add'
      newworkdetails = Newwork.find(params[:newworkid]).newworkdetails
      #newrawid = Newdepotdetail.find(params[:newrawid]).newdepot.newraw_id
      newrawid = Newraw.find(params[:newrawid]).id
      newrawprice = Newraw.find(Newdepot.find(params[:newrawid]).newraw_id).id
      newworkdetails.create!(newraw_id:newrawid,width:params[:width],height:params[:height],userheight:params[:userheight],widthtype:params[:widthtype],heighttype:params[:heighttype],number:params[:number],lossarea:params[:lossarea],area:params[:area],cost:Newdepot.find(newrawid).price, price:newrawprice)
    elsif params[:way]=='edit'
      #inrawdepotdetails = Inrawdepot.find(params[:inrawdepotid]).inrawdepotdetails.where('id =?',params[:rawid]).first
      newworkdetails = Newwork.find(params[:newworkid]).newworkdetails.where('id =?',params[:rawdata]).first
      #debugger
      if params[:newrawid].to_s != ''
        rawid = Newraw.find(Newdepot.find(params[:newrawid]).newraw_id).id
        #debugger
        newworkdetails.newraw_id = rawid
      end
      newworkdetails.width = params[:width]
      newworkdetails.height = params[:height]
      newworkdetails.userheight = params[:userheight]
      newworkdetails.number = params[:number]
      newworkdetails.widthtype = params[:widthtype]
      newworkdetails.heighttype = params[:heighttype]
      newworkdetails.lossarea = params[:lossarea]
      newworkdetails.area = params[:area]
      newworkdetails.save!
    end
    newwork = Newwork.find(params[:newworkid])
    newworkdetails = newwork.newworkdetails
    newworkdetails.each do |f|
      cost = Newdepot.find_by(newraw_id:f.newraw_id).price
      f.cost = cost.to_f * f.width.to_f / 1000 * f.height.to_f / 1000
      price = Newraw.find(f.newraw_id).price
      f.price = price.to_f * f.width.to_f / 1000 * f.height.to_f / 1000 + price.to_f * f.lossarea.to_f / 1000
      f.save
    end
    render json: '{"status":"200"}'
  end

  def deleteinrawdetail
    params[:ids].each do |f|
      preorderdetails = Newworkdetail.find(f)
      preorderdetails.destroy
    end
    render json: '{"status":"200"}'
  end

  def work
    ordernumber = Time.now.strftime('%Y%m%d')
    smnumber = Inworkdepot.last
    mystep ='001'
    if smnumber
      if smnumber.ordernumber[0..7] == ordernumber
        mystep=smnumber.ordernumber
        mystep.reverse!
        mystep = mystep[0..2]
        mystep.reverse!
        mystep = (mystep.to_i+1).to_s
        (3-mystep.length).times do
          mystep = '0' + mystep
        end
        ordernumber += mystep
      else
        ordernumber += mystep
      end
    else
      ordernumber += mystep
    end

    @inworkdepot = Inworkdepot.create(ordernumber:ordernumber,isnew:1,preordernumber:params[:preorderid])
    render json: @inworkdepot.id.to_s
  end

  def getcooperuser
    cooperusers = Cooper.find(params[:id]).cooperusers
    render json: cooperusers.to_json
  end

  def getcumtomerbyid
    customer = Customer.find(params[:id])
    render json: customer.to_json
  end

  def group
    ids = params[:ids]
    newwork = Newwork.find(params[:newworkid])
    newworkdetails = newwork.newworkdetails
    maxindex = 1
    newworkdetails.each do |f|
      if f.group && f.group[-1,1].to_i >= maxindex
        maxindex = f.group[-1,1].to_i + 1
      end
    end
    ids.each do |f|
      newworkdetail = Newworkdetail.find(f)
      newworkdetail.group = '组'+maxindex.to_s
      newworkdetail.save
    end
  end


  private
# Use callbacks to share common setup or constraints between actions.
  def set_newwork
    @newwork = Newwork.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def newwork_params
    params.require(:newwork).permit(:ordernumber, :user, :summary, :isnew, :preordernumber, :number, :cooper_id, :customer_id, :designer_id, :fiter_id, :line, :wave)
  end

end
