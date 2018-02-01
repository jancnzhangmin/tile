class InrawdepotsController < ApplicationController

  before_action :set_inrawdepot, only: [:show, :edit, :update, :destroy]
  def index
    ordernumber = Time.now.strftime('%Y%m%d')
    smnumber = Inrawdepot.last
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
    @inrawdepot = Inrawdepot.create!(ordernumber:ordernumber,isnew:1)
    redirect_to edit_inrawdepot_path(@inrawdepot)
  end

  def edit

  end

  def new
    @inrawdepot = Inrawdepot.new
  end

  def create
    @inrawdepot = User.new(inrawdepot_params)
    respond_to do |format|
      if @inrawdepot.save

        format.html { redirect_to inrawdepots_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @inrawdepot.update(inrawdepot_params)
        @inrawdepot.isnew = 0
        @inrawdepot.save
        inrawdepotdetails = @inrawdepot.inrawdepotdetails
        inrawdepotdetails.each do |f|
          rawdepot = Rawdepot.where('raw_id = ?',f.raw_id)
          if rawdepot.count > 0
            firstrawdepot = rawdepot.first

            #移动平均单价=（本次进货的成本+原有库存的成本）/（本次进货数量+原有存货数量
            if (f.number + firstrawdepot.number) == 0
              firstrawdepot.price = f.price
            else
              firstrawdepot.price = (f.price * f.number + firstrawdepot.price * firstrawdepot.number) / (f.number + firstrawdepot.number)
            end

            firstrawdepot.number += f.number
            firstrawdepot.save
          else
            Rawdepot.create(raw_id:f.raw_id,price:f.price,number:f.number)
          end
        end
        format.html { redirect_to inrawdepotrecord_path(@inrawdepot), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @inrawdepot }
      else
        format.html { render :edit }
        format.json { render json: @inrawdepot.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @inrawdepot.destroy
    respond_to do |format|
      format.html { redirect_to inrawdepots_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  class Inrawdepotdetailclass
    attr :id,true
    attr :raw,true
    attr :spec,true
    attr :unit,true
    attr :price,true
    attr :number,true
    attr :sum,true
  end

  def getdata
    @inrawdepotdetails = Inrawdepot.find(params[:inrawdepotid]).inrawdepotdetails
    inrawdepotdetailarr = Array.new
    @inrawdepotdetails.each do |f|
      inrawdepotdetailcla = Inrawdepotdetailclass.new
      inrawdepotdetailcla.id = f.id
      inrawdepotdetailcla.raw = f.raw.name
      inrawdepotdetailcla.spec = f.raw.spec
      inrawdepotdetailcla.unit = f.raw.unit
      inrawdepotdetailcla.price = f.price
      inrawdepotdetailcla.number = f.number
      inrawdepotdetailcla.sum = f.sum
      inrawdepotdetailarr.push inrawdepotdetailcla
    end
    render json:inrawdepotdetailarr
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

  class Rawclass
    attr :id,true
    attr :pinyin,true
    attr :name,true
    attr :spec,true
  end

  def getraw
    raws = Raw.all
    rawarr = Array.new
    raws.each do |f|
      rawcla = Rawclass.new
      rawcla.id = f.id
      rawcla.pinyin = f.pinyin
      rawcla.name = f.name
      rawcla.spec = f.spec
      rawarr.push rawcla
    end
    render json:rawarr
  end

  def getrawbyid
    raw = Raw.find(params[:id])
    render json:raw
  end

  def changeinrawdetail
    if params[:way] =='add'
      inrawdepotdetails = Inrawdepot.find(params[:inrawdepotid]).inrawdepotdetails
      hasdepot = 0
      inrawdepotdetails.each do |f|
        if f.raw_id.to_s == params[:rawid]
          hasdepot = 1
        end
      end
      if hasdepot == 1
        localrawdepotdetail = inrawdepotdetails.where('raw_id = ?',params[:rawid]).first
        localrawdepotdetail.number += params[:number].to_f
        localrawdepotdetail.price = params[:price]
        localrawdepotdetail.sum = params[:price].to_f * params[:number].to_f
        localrawdepotdetail.save
      else
        inrawdepotdetails.create(raw_id:params[:rawid],price:params[:price],number:params[:number],sum:params[:sum])
      end
    elsif params[:way]=='edit'
      inrawdepotdetails = Inrawdepot.find(params[:inrawdepotid]).inrawdepotdetails.where('id =?',params[:rawid]).first
      inrawdepotdetails.number = params[:number].to_f
      inrawdepotdetails.price = params[:price]
      inrawdepotdetails.sum = params[:price].to_f * params[:number].to_f
      inrawdepotdetails.save
    elsif params[:way] == 'delete'
      inrawdepotdetails = Inrawdepotdetail.where('id in (?)',params[:rawid])
      inrawdepotdetails.each do |f|
        f.destroy
      end
    end
    render json: '{"status":"200"}'
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_inrawdepot
    @inrawdepot = Inrawdepot.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def inrawdepot_params
    params.require(:inrawdepot).permit(:ordernumber, :summary, :user, :isnew, :supplier_id)
  end

end
