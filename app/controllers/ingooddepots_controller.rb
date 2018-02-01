class IngooddepotsController < ApplicationController

  before_action :set_ingooddepot, only: [:show, :edit, :update, :destroy]
  def index
    ordernumber = Time.now.strftime('%Y%m%d')
    smnumber = Ingooddepot.last
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
    @ingooddepot = Ingooddepot.create!(ordernumber:ordernumber,isnew:1)
    redirect_to edit_ingooddepot_path(@ingooddepot)
  end

  def edit

  end

  def new
    @ingooddepot = Ingooddepot.new
  end

  def create
    @ingooddepot = Good.new(ingooddepot_params)
    respond_to do |format|
      if @ingooddepot.save

        format.html { redirect_to ingooddepots_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @ingooddepot.update(ingooddepot_params)
        @ingooddepot.isnew = 0
        @ingooddepot.save
        ingooddepotdetails = @ingooddepot.ingooddepotdetails
        ingooddepotdetails.each do |f|
          gooddepot = Gooddepot.where('good_id = ?',f.good_id)
          if gooddepot.count > 0
            firstgooddepot = gooddepot.first

            #移动平均单价=（本次进货的成本+原有库存的成本）/（本次进货数量+原有存货数量




            firstgooddepot.number += f.number
            firstgooddepot.save
          else
            Gooddepot.create!(good_id:f.good_id,number:f.number)
          end
        end
        format.html { redirect_to ingooddepotrecord_path(@ingooddepot), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingooddepot }
      else
        format.html { render :edit }
        format.json { render json: @ingooddepot.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @ingooddepot.destroy
    respond_to do |format|
      format.html { redirect_to ingooddepots_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  class Ingooddepotdetailclass
    attr :id,true
    attr :good,true
    attr :spec,true
    attr :unit,true
    attr :number,true
  end

  def getdata
    @ingooddepotdetails = Ingooddepot.find(params[:ingooddepotid]).ingooddepotdetails
    ingooddepotdetailarr = Array.new
    @ingooddepotdetails.each do |f|
      ingooddepotdetailcla = Ingooddepotdetailclass.new
      ingooddepotdetailcla.id = f.id
      ingooddepotdetailcla.good = f.good.name
      ingooddepotdetailcla.spec = f.good.spec
      ingooddepotdetailcla.unit = f.good.unit
      ingooddepotdetailcla.number = f.number
      ingooddepotdetailarr.push ingooddepotdetailcla
    end
    render json:ingooddepotdetailarr
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
      ingooddepotdetails = Ingooddepot.find(params[:ingooddepotid]).ingooddepotdetails
      hasdepot = 0
      ingooddepotdetails.each do |f|
        if f.good_id.to_s == params[:goodid]
          hasdepot = 1
        end
      end
      if hasdepot == 1
        localgooddepotdetail = ingooddepotdetails.where('good_id = ?',params[:rawid]).first
        localgooddepotdetail.number += params[:number].to_f

        localgooddepotdetail.save
      else
        ingooddepotdetails.create!(good_id:params[:goodid],number:params[:number])
      end
    elsif params[:way]=='edit'
      ingooddepotdetails = Ingooddepot.find(params[:ingooddepotid]).ingooddepotdetails.where('id =?',params[:goodid]).first
      ingooddepotdetails.number = params[:number].to_f
      ingooddepotdetails.save
    elsif params[:way] == 'delete'
      ingooddepotdetails = Ingooddepotdetail.where('id in (?)',params[:goodid])
      ingooddepotdetails.each do |f|
        f.destroy
      end
    end
    render json: '{"status":"200"}'
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_ingooddepot
    @ingooddepot = Ingooddepot.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def ingooddepot_params
    params.require(:ingooddepot).permit(:ordernumber, :summary, :user, :isnew)
  end

end
