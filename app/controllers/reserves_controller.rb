class ReservesController < ApplicationController

  before_action :set_reserve, only: [:show, :edit, :update, :destroy]
  def index
    @reserves = Reserve.all.where('isnew = 0')
  end

  def edit

  end

  def new
    ordernumber = Time.now.strftime('%Y%m%d')
    smnumber = Reserve.last
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
    @reserve = Reserve.create!(ordernumber:ordernumber,isnew:1)
    redirect_to edit_reserf_path(@reserve)
  end

  def create
    @reserve = Reserve.new(reserve_params)
    respond_to do |format|
      if @reserve.save

        format.html { redirect_to reserves_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @reserve.update(reserve_params)
        @reserve.isnew = 0
        @reserve.save
        format.html { redirect_to reserf_path(@reserve), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @reserve }
      else
        format.html { render :edit }
        format.json { render json: @reserve.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @reserve.destroy
    respond_to do |format|
      format.html { redirect_to reserves_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  class Reservedetailclass
    attr :id,true
    attr :sale,true
    attr :spec,true
    attr :unit,true
    attr :price,true
    attr :number,true
    attr :sum,true
  end

  def getdata
    @reservedetails = Reserve.find(params[:reserveid]).reservedetails
    reservedetailarr = Array.new
    @reservedetails.each do |f|
      reservedetailcla = Reservedetailclass.new
      reservedetailcla.id = f.id
      reservedetailcla.sale = f.sale.name
      reservedetailcla.spec = f.sale.spec
      reservedetailcla.unit = f.sale.unit
      reservedetailcla.price = f.sale.price
      reservedetailcla.number = f.number
      reservedetailcla.sum = f.sum
      reservedetailarr.push reservedetailcla
    end
    render json:reservedetailarr
  end

  class Customerclass
    attr :id,true
    attr :name,true
  end

  def getcustomer
    customers = Customer.all
    customerarr = Array.new
    customers.each do |f|
      customercla = Customerclass.new
      customercla.id = f.id
      customercla.name = f.name
      customerarr.push customercla
    end
    render json:customerarr
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

  def getsalebyid
    sale = Sale.find(params[:id])
    render json:sale
  end

  def changereserve
    if params[:way] =='add'
      reservedetails = Reserve.find(params[:reserveid]).reservedetails
      reservedetails.create(sale_id:params[:saleid],price:params[:price],number:params[:number],sum:params[:sum])
    elsif params[:way]=='edit'
      reservedetail = Reservedetail.find(params[:saleid])
      reservedetail.number = params[:number].to_f
      reservedetail.price = params[:price]
      reservedetail.sum = params[:price].to_f * params[:number].to_f
      reservedetail.save
    elsif params[:way] == 'delete'
      reservedetail = Reservedetail.where('id in (?)',params[:saleid])
      reservedetail.each do |f|
        f.destroy
      end
    end
    render json: '{"status":"200"}'
  end

  def trans
    ordernumber = Time.now.strftime('%Y%m%d')
    smnumber = Salere.last
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

    reserve = Reserve.find(params[:reserveid])
    reservedetails = reserve.reservedetails
    salere = Salere.create(ordernumber:ordernumber,customer_id:reserve.customer_id,summary:reserve.summary,user:reserve.user,isnew:0)
    saleredetails = salere.saleredetails
    reservedetails.each do |f|
      saleredetails.create(sale_id:f.sale_id,number:f.number,price:f.price,sum:f.sum)
    end
    reserve.status = 1
    reserve.save
    render json: '{"status":"200"}'
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_reserve
    @reserve = Reserve.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def reserve_params
    params.require(:reserve).permit(:ordernumber, :customer_id, :orderdate, :summary, :user_id, :user, :pay)
  end

end
