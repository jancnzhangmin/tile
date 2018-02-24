class ReturngoodsController < ApplicationController

  before_action :set_returngood, only: [:show, :edit, :update, :destroy]
  def index
    @returngoods = Returngood.all.where('isnew = 0')
  end

  def edit
    @users = User.all
  end

  def new
    ordernumber = Time.now.strftime('%Y%m%d')
    smnumber = Returngood.last
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
    @returngood = Returngood.create!(ordernumber:ordernumber,isnew:1)
    redirect_to edit_returngood_path(@returngood)
  end

  def create
    @returngood = Returngood.new(returngood_params)
    respond_to do |format|
      if @returngood.save

        format.html { redirect_to returngoods_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @returngood.update(returngood_params)
        @returngood.isnew = 0
        @returngood.save
        returngooddetails = @returngood.returngooddetails
        returngooddetails.each do |f|
          gooddepot = Gooddepot.where('good_id = ?',f.good_id)
          if gooddepot.count > 0
            firstgooddepot = gooddepot.first

            #移动平均单价=（本次进货的成本+原有库存的成本）/（本次进货数量+原有存货数量




            firstgooddepot.borrownumber -= f.number
            firstgooddepot.save
          else
            #Gooddepot.create!(good_id:f.good_id,number:f.number)
          end
        end
        format.html { redirect_to returngoods_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @borrowgood }
      else
        format.html { render :edit }
        format.json { render json: @returngood.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @returngood.destroy
    respond_to do |format|
      format.html { redirect_to returngoods_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  class Returngoodclass
    attr :id,true
    attr :good,true
    attr :spec,true
    attr :unit,true
    attr :number,true
  end

  def getdata
    @returngooddetails = Returngood.find(params[:returngoodid]).returngooddetails
    returngooddetailarr = Array.new
    @returngooddetails.each do |f|
      returngooddetailcla = Returngoodclass.new
      returngooddetailcla.id = f.id
      returngooddetailcla.good = f.good.name
      returngooddetailcla.spec = f.good.spec
      returngooddetailcla.unit = f.good.unit
      returngooddetailcla.number = f.number
      returngooddetailarr.push returngooddetailcla
    end
    render json:returngooddetailarr
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

  class Goodclass
    attr :id,true
    attr :pinyin,true
    attr :name,true
    attr :spec,true
  end

  def getgood
    goods = Good.all
    goodarr = Array.new
    goods.each do |f|
      goodcla = Goodclass.new
      goodcla.id = f.id
      goodcla.pinyin = f.pinyin
      goodcla.name = f.name
      goodcla.spec = f.spec
      goodarr.push goodcla
    end
    render json:goodarr
  end

  def getgoodbyid
    good = Good.find(params[:id])
    render json:good
  end

  def changeingooddetail
    if params[:way] =='add'
      returngooddetails = Returngood.find(params[:returngoodid]).returngooddetails
      hasdepot = 0
      returngooddetails.each do |f|
        if f.good_id.to_s == params[:goodid]
          hasdepot = 1
        end
      end
      if hasdepot == 1
        localreturngooddetail = returngooddetails.where('id = ?',params[:goodid]).first
        localreturngooddetail.number += params[:number].to_f

        localreturngooddetail.save
      else
        returngooddetails.create!(good_id:params[:goodid],number:params[:number])
      end
    elsif params[:way]=='edit'
      returngooddetails = Returngood.find(params[:returngoodid]).returngooddetails.where('id =?',params[:goodid]).first
      returngooddetails.number = params[:number].to_f
      returngooddetails.save
    elsif params[:way] == 'delete'
      returngooddetails = Returngooddetail.where('id in (?)',params[:goodid])
      returngooddetails.each do |f|
        f.destroy
      end
    end
    render json: '{"status":"200"}'
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_returngood
    @returngood = Returngood.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def returngood_params
    params.require(:returngood).permit(:ordernumber, :summary, :user_id, :isnew, :returnuser_id)
  end

end
