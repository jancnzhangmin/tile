class SaleresController < ApplicationController

  before_action :set_salere, only: [:show, :edit, :update, :destroy]
  def index
    @saleres = Salere.all.where('isnew = 0')
  end

  def edit

  end

  def new
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
    @salere = Salere.create!(ordernumber:ordernumber,isnew:1)
    redirect_to edit_salere_path(@salere)
  end

  def create
    @salere = Salere.new(salere_params)
    respond_to do |format|
      if @salere.save

        format.html { redirect_to saleres_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @salere.update(salere_params)
        @salere.isnew = 0
        @salere.save
        format.html { redirect_to salere_path(@salere), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @salere }
      else
        format.html { render :edit }
        format.json { render json: @salere.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @salere.destroy
    respond_to do |format|
      format.html { redirect_to saleres_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  class Saleredetailclass
    attr :id,true
    attr :sale,true
    attr :spec,true
    attr :unit,true
    attr :price,true
    attr :number,true
    attr :sum,true
  end

  def getdata
    @saleredetails = Salere.find(params[:salereid]).saleredetails
    saleredetailarr = Array.new
    @saleredetails.each do |f|
      saleredetailcla = Saleredetailclass.new
      saleredetailcla.id = f.id
      saleredetailcla.sale = f.sale.name
      saleredetailcla.spec = f.sale.spec
      saleredetailcla.unit = f.sale.unit
      saleredetailcla.price = f.sale.price
      saleredetailcla.number = f.number
      saleredetailcla.sum = f.sum
      saleredetailarr.push saleredetailcla
    end
    render json:saleredetailarr
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

  def changesalere
    if params[:way] =='add'
      saleredetails = Salere.find(params[:salereid]).saleredetails
      saleredetails.create(sale_id:params[:saleid],price:params[:price],number:params[:number],sum:params[:sum])
    elsif params[:way]=='edit'
      saleredetail = Saleredetail.find(params[:saleid])
      saleredetail.number = params[:number].to_f
      saleredetail.price = params[:price]
      saleredetail.sum = params[:price].to_f * params[:number].to_f
      saleredetail.save
    elsif params[:way] == 'delete'
      saleredetail = Saleredetail.where('id in (?)',params[:saleid])
      saleredetail.each do |f|
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
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_salere
    @salere = Salere.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def salere_params
    params.require(:salere).permit(:ordernumber, :customer_id, :orderdate, :summary, :user)
  end

end
