class PreordersController < ApplicationController

  before_action :set_preorder, only: [:show, :edit, :update, :destroy]
  def index
    @preorders = Preorder.where('isnew = 0')
  end

  def edit
@coopers = Cooper.all
@customers = Customer.all
    @users = User.all
  end

  def new
    ordernumber = Time.now.strftime('%Y%m%d')
    smnumber = Preorder.last
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
    @preorder = Preorder.create(ordernumber:ordernumber,isnew:1)
    redirect_to edit_preorder_path(@preorder)
  end

  def create
    @preorder = Preorder.new(preorder_params)
    respond_to do |format|

      if @preorder.save
        format.html { redirect_to preorders_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @preorder.update(preorder_params)
        @preorder.isnew = 0
        @preorder.save
        format.html { redirect_to preorders_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @preorder }
      else
        format.html { render :edit }
        format.json { render json: @preorder.errors, status: :unprocessable_entity }
      end
    end

  end

  def show
    @coopers = Cooper.all
    @customers = Customer.all
  end


  def destroy
    @preorder.destroy
    respond_to do |format|
      format.html { redirect_to preorders_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  class Preorderdetailclass
    attr :id,true
    attr :name,true
    attr :area,true
    attr :unit,true
    attr :number,true
    attr :price,true
    attr :sum,true
    attr :summary,true
    attr :width,true
    attr :height,true
    attr :userheight,true
    attr :rawsum,true

  end

  def getdata
    @preorderdetails = Preorder.find(params[:preorderid]).preorderdetails
    preorderdetailarr = Array.new
    @preorderdetails.each do |f|
      preorderdetailcla = Preorderdetailclass.new
      preorderdetailcla.id = f.id
      preorderdetailcla.name = f.preraw.name
      preorderdetailcla.area = f.area
      preorderdetailcla.unit = f.unit
      preorderdetailcla.price = f.price
      preorderdetailcla.number = f.number
      preorderdetailcla.sum = f.sum
      preorderdetailcla.summary = f.summary
      preorderdetailcla.height = f.height
      preorderdetailcla.userheight = f.userheight
      preorderdetailcla.width = f.width
      preorderdetailcla.rawsum = f.width.to_f / 1000 * f.height.to_f / 1000 * f.number.to_f
      preorderdetailarr.push preorderdetailcla
    end
    render json:preorderdetailarr
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
    preraws = Preraw.all
    prerawarr = Array.new
    preraws.each do |f|
      prerawcla = Prerawclass.new
      prerawcla.id = f.id
      prerawcla.pinyin = f.pinyin
      prerawcla.name = f.name
      prerawarr.push prerawcla
    end
    render json:prerawarr
  end

  def getrawbyid
    raw = Raw.find(params[:id])
    render json:raw
  end

  def changeinrawdetail
    if params[:way] =='add'
      preorderdetails = Preorder.find(params[:preorderid]).preorderdetails
      sum = params[:price].to_f * params[:number].to_f
      preorderdetails.create(preraw_id:params[:prerawid],width:params[:width],height:params[:height],userheight:params[:userheight],area:params[:area],number:params[:number],price:params[:price],summary:params[:summary],sum:sum,unit:params[:unit])
    elsif params[:way]=='edit'
      inrawdepotdetails = Inrawdepot.find(params[:inrawdepotid]).inrawdepotdetails.where('id =?',params[:rawid]).first
      inrawdepotdetails.number = params[:number].to_f
      inrawdepotdetails.price = params[:price]
      inrawdepotdetails.sum = params[:price].to_f * params[:number].to_f
      inrawdepotdetails.save
    end
    render json: '{"status":"200"}'
  end

  def deleteinrawdetail
    params[:ids].each do |f|
      preorderdetails = Preorderdetail.find(f)
      preorderdetails.destroy
    end
    render json: '{"status":"200"}'
  end

  def work
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

    @newwork = Newwork.create(ordernumber:ordernumber,isnew:1,preordernumber:params[:preorderid])
    render json: @newwork.id.to_s
  end

  def dowork
    workorder = Newwork.find_by_preordernumber(params[:id])
    if workorder
      redirect_to edit_newwork_path(workorder)
    else
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

      @newwork = Newwork.create(ordernumber:ordernumber,isnew:1,preordernumber:params[:id])
      redirect_to edit_newwork_path(@newwork)
    end
  end

  def getcooperuser
    cooperusers = Cooper.find(params[:id]).cooperusers
    render json: cooperusers.to_json
  end


  private
# Use callbacks to share common setup or constraints between actions.
  def set_preorder
    @preorder = Preorder.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def preorder_params
    params.require(:preorder).permit(:newraw_id, :pay, :user, :isnew, :ordernumber, :installdate, :cooper_id, :cooperuser_id, :address, :customer_id)
  end

end

