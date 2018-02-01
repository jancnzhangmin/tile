class InsaledepotsController < ApplicationController

  before_action :set_insaledepot, only: [:show, :edit, :update, :destroy]
  def index
    ordernumber = Time.now.strftime('%Y%m%d')
    smnumber = Insaledepot.last
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
    @insaledepot = Insaledepot.create!(ordernumber:ordernumber,isnew:1)
    redirect_to edit_insaledepot_path(@insaledepot)
  end

  def edit

  end

  def new
    @insaledepot = Insaledepot.new
  end

  def create
    @insaledepot = Insaledepot.new(insaledepot_params)
    respond_to do |format|
      if @insaledepot.save

        format.html { redirect_to insaledepots_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @insaledepot.update(insaledepot_params)
        @insaledepot.isnew = 0
        @insaledepot.save
        insaledepotdetails = @insaledepot.insaledepotdetails
        insaledepotdetails.each do |f|
          saledepot = Saledepot.where('sale_id = ?',f.sale_id)
          if saledepot.count > 0
            firstsaledepot = saledepot.first

            #移动平均单价=（本次进货的成本+原有库存的成本）/（本次进货数量+原有存货数量
            if (f.salenumber + firstsaledepot.number) == 0
              firstsaledepot.price = f.saleprice
            else
              firstsaledepot.price = (f.saleprice * f.salenumber + firstsaledepot.price * firstsaledepot.number) / (f.salenumber + firstsaledepot.number)

            end

            firstsaledepot.number += f.salenumber
            firstsaledepot.save
          else
            Saledepot.create(sale_id:f.sale_id,price:f.saleprice,number:f.salenumber)
          end
        end
        format.html { redirect_to insaledepotrecord_path(@insaledepot), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @insaledepot }
      else
        format.html { render :edit }
        format.json { render json: @insaledepot.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @insaledepot.destroy
    respond_to do |format|
      format.html { redirect_to insaledepots_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  class Insaledepotdetailclass
    attr :id,true
    attr :sale,true
    attr :spec,true
    attr :unit,true
    attr :price,true
    attr :number,true
    attr :sum,true
  end

  def getdata
    @insaledepotdetails = Insaledepot.find(params[:insaledepotid]).insaledepotdetails
    insaledepotdetailarr = Array.new
    @insaledepotdetails.each do |f|
      insaledepotdetailcla = Insaledepotdetailclass.new
      insaledepotdetailcla.id = f.id
      insaledepotdetailcla.sale = f.sale.name
      insaledepotdetailcla.spec = f.sale.spec
      insaledepotdetailcla.unit = f.sale.unit
      insaledepotdetailcla.price = f.saleprice
      insaledepotdetailcla.number = f.salenumber
      insaledepotdetailcla.sum = f.salesum
      insaledepotdetailarr.push insaledepotdetailcla
    end
    render json:insaledepotdetailarr
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

  class Saleclass
    attr :id,true
    attr :pinyin,true
    attr :name,true
    attr :spec,true
  end

  def getsale
    sales = Sale.all
    salearr = Array.new
    sales.each do |f|
      salecla = Saleclass.new
      salecla.id = f.id
      salecla.pinyin = f.pinyin
      salecla.name = f.name
      salecla.spec = f.spec
      salearr.push salecla
    end
    render json:salearr
  end

  class Workclass
    attr :id,true
    attr :pinyin,true
    attr :name,true
    attr :spec,true
  end

  def getwork
    works = Workdepot.all
    workarr = Array.new
    works.each do |f|
      workcla = Workclass.new
      workcla.id = f.id
      workcla.pinyin = f.raw.pinyin
      workcla.name = f.raw.name
      workcla.spec = f.raw.spec
      workarr.push workcla
    end
    render json:workarr
  end

  def getsalebyid
    sale = Sale.find(params[:id])
    render json:sale
  end

  def getworkbyid
    work = Workdepot.find(params[:id])
    render json:work
  end

  def changeinsaledetail
    if params[:way] =='add'
      insaledepotdetails = Insaledepot.find(params[:insaledepotid]).insaledepotdetails
      hasdepot = 0
      insaledepotdetails.each do |f|
        if f.sale_id.to_s == params[:saleid]
          hasdepot = 1
        end
      end
      if hasdepot == 1
        localsaledepotdetail = insaledepotdetails.where('sale_id = ?',params[:saleid]).first
        localsaledepotdetail.salenumber += params[:salenumber].to_f
        localsaledepotdetail.saleprice = params[:saleprice]
        localsaledepotdetail.salesum = params[:saleprice].to_f * params[:salenumber].to_f
        localsaledepotdetail.rawprice = params[:workprice]
        localsaledepotdetail.rawnumber = params[:workprice]
        localsaledepotdetail.rawsum = params[:worknumber].to_f * params[:worknumber].to_f
        localsaledepotdetail.save
      else

        insaledepotdetails.create(sale_id:params[:saleid],saleprice:params[:saleprice],salenumber:params[:salenumber],salesum:params[:saleprice].to_f * params[:salenumber].to_f,raw_id:params[:workid],rawprice:params[:workprice],rawnumber:params[:worknumber],rawsum:params[:worknumber].to_f * params[:workprice].to_f)

      end
    elsif params[:way]=='edit'
      insaledepotdetails = Insaledepot.find(params[:insaledepotid]).insaledepotdetails.where('id =?',params[:saleid]).first
      insaledepotdetails.number = params[:number].to_f
      insaledepotdetails.price = params[:price]
      insaledepotdetails.sum = params[:price].to_f * params[:number].to_f
      insaledepotdetails.save
    elsif params[:way] == 'delete'
      insaledepotdetails = Insaledepotdetail.where('id in (?)',params[:saleid])
      insaledepotdetails.each do |f|
        f.destroy
      end
    end
    render json: '{"status":"200"}'
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_insaledepot
    @insaledepot = Insaledepot.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def insaledepot_params
    params.require(:insaledepot).permit(:ordernumber, :summary, :user, :isnew)
  end

end
