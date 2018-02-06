class NewworksController < ApplicationController

  before_action :set_newwork, only: [:show, :edit, :update, :destroy, :worklian]
  def index
    @newworks = Newwork.where('isnew = 0')
  end

  def edit
    @coopers = Cooper.all
@users = User.all
  end

  def new
    ordernumber = Time.now.strftime('%Y%m%d')
    smnumber = Newwork.last
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
    @newwork = Newwork.create(ordernumber:ordernumber,isnew:1)
    redirect_to edit_preorder_path(@preorder)
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

  end

  def getdata
    @newworkdetails = Newwork.find(params[:newworkid]).newworkdetails.order("width desc, height desc")
    newworkdetailarr = Array.new
    @newworkdetails.each do |f|
      newworkdetailcla = Newworkdetailclass.new
      newworkdetailcla.id = f.id
      newworkdetailcla.name = f.newraw.name
      newworkdetailcla.width = f.width
      newworkdetailcla.height = f.height
      newworkdetailcla.userheight = f.userheight
      newworkdetailcla.number = f.number
      newworkdetailcla.widthtype = f.widthtype
      newworkdetailcla.heighttype = f.heighttype
      newworkdetailarr.push newworkdetailcla
    end
    render json:newworkdetailarr
  end

  class Totalclass
    attr :name,true
    attr :number,true
    attr :unit,true
    attr :toalnumber,true
  end

  def gettotal
    rawarr = Array.new
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
          usertotalcla.number += (f.width / 1000) * (f.userheight.to_f / 1000) *f.number
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
    lomacla.name = '罗马边'
    xiaoyuancla.name = '小圆边'
    lomacla.number = 0
    xiaoyuancla.number = 0
    lomacla.unit = 'm'
    xiaoyuancla.unit = 'm'

    userlomacla.name = '罗马边'
    userxiaoyuancla.name = '小圆边'
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
        userlomacla.number += f.userheight.to_f / 1000 * f.number
      end
      if f.widthtype == '03'
        lomacla.number += (f.width / 1000) * 2 * f.number
        userlomacla.number += (f.width / 1000) * 2 * f.number
      end
      if f.heighttype == '03'
        lomacla.number += (f.height / 1000) * 2 * f.number
        userlomacla.number += (f.userheight.to_f / 1000) * 2 * f.number
      end

      if f.widthtype == '04' || f.widthtype == '06'
        xiaoyuancla.number += f.width / 1000 * f.number
        userxiaoyuancla.number += f.width / 1000 * f.number
      end
      if f.heighttype == '04' || f.heighttype == '06'
        xiaoyuancla.number += f.height / 1000 * f.number
        userxiaoyuancla.number += f.userheight.to_f / 1000 * f.number
      end
      if f.widthtype == '05'
        xiaoyuancla.number += (f.width / 1000) * 2 * f.number
        userxiaoyuancla.number += (f.width / 1000) * 2 * f.number
      end
      if f.heighttype == '05'
        xiaoyuancla.number += (f.height / 1000) * 2 * f.number
        userxiaoyuancla.number += (f.userheight.to_f / 1000) * 2 * f.number
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
    raw = Newdepotdetail.find(params[:id])

    render json:raw
  end

  def changenewworkdetail
    if params[:way] =='add'
      newworkdetails = Newwork.find(params[:newworkid]).newworkdetails
      #newrawid = Newdepotdetail.find(params[:newrawid]).newdepot.newraw_id
      newrawid = Newraw.find(Newdepot.find(params[:newrawid]).newraw_id).id
      newworkdetails.create!(newraw_id:newrawid,width:params[:width],height:params[:height],userheight:params[:userheight],widthtype:params[:widthtype],heighttype:params[:heighttype],number:params[:number])
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
      newworkdetails.save!
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


  private
# Use callbacks to share common setup or constraints between actions.
  def set_newwork
    @newwork = Newwork.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def newwork_params
    params.require(:newwork).permit(:ordernumber, :user, :summary, :isnew, :preordernumber, :number)
  end

end
