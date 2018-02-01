class InworkdepotsController < ApplicationController

  before_action :set_inworkdepot, only: [:show, :edit, :update, :destroy]
  def index
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
    @inworkdepot = Inworkdepot.create!(ordernumber:ordernumber,isnew:1)
    redirect_to edit_inworkdepot_path(@inworkdepot)
  end

  def edit

  end

  def new
    @inrawdepot = Inrawdepot.new
  end

  def create
    @inrawdepot = Inrawdepot.new(inworkdepot_params)
    respond_to do |format|
      if @inrawdepot.save

        format.html { redirect_to inworkdepots_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @inworkdepot.update(inworkdepot_params)
        @inworkdepot.isnew = 0
        @inworkdepot.save
        inworkdepotdetails = @inworkdepot.inworkdepotdetails
        inworkdepotdetails.each do |f|
          workdepot = Workdepot.where('raw_id = ?',f.raw_id)
          if workdepot.count > 0
            firstworkdepot = workdepot.first

            #移动平均单价=（本次进货的成本+原有库存的成本）/（本次进货数量+原有存货数量
            #firstworkdepot.price = (f.price * f.number + firstworkdepot.price * firstworkdepot.number) / (f.number + firstworkdepot.number)
            firstworkdepot.number += f.number
            firstworkdepot.save
          else
            Workdepot.create(raw_id:f.raw_id,price:f.price,number:f.number)
          end
          rawdepot = Rawdepot.where('raw_id =?',f.raw_id).first
          rawdepot.number -= f.number
          rawdepot.save
        end
        format.html { redirect_to inworkdepotrecord_path(@inworkdepot), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @inworkdepot }
      else
        format.html { render :edit }
        format.json { render json: @inworkdepot.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @inworkdepot.destroy
    respond_to do |format|
      format.html { redirect_to inworkdepots_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  class Inworkdepotdetailclass
    attr :id,true
    attr :raw,true
    attr :spec,true
    attr :unit,true
    attr :price,true
    attr :number,true
    attr :sum,true
  end

  def getdata
    @inworkdepotdetails = Inworkdepot.find(params[:inworkdepotid]).inworkdepotdetails
    inworkdepotdetailarr = Array.new
    @inworkdepotdetails.each do |f|
      inworkdepotdetailcla = Inworkdepotdetailclass.new
      inworkdepotdetailcla.id = f.id
      inworkdepotdetailcla.raw = f.raw.name
      inworkdepotdetailcla.spec = f.raw.spec
      inworkdepotdetailcla.unit = f.raw.unit
      inworkdepotdetailcla.price = f.price
      inworkdepotdetailcla.number = f.number
      inworkdepotdetailcla.sum = f.sum
      inworkdepotdetailarr.push inworkdepotdetailcla
    end
    render json:inworkdepotdetailarr
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
    attr :depotnumber,true
    attr :unit,true
    attr :price,true
  end

  def getraw
    raws = Rawdepot.all
    rawarr = Array.new
    raws.each do |f|
      raw = Raw.where('id = ?',f.raw_id).first
      rawcla = Rawclass.new
      rawcla.id = f.id
      rawcla.pinyin = raw.pinyin
      rawcla.name = raw.name
      rawcla.spec = raw.spec
      #rawcla.depotnumber = f.number
      rawarr.push rawcla
    end
    render json:rawarr
  end

  def getrawbyid
    raw = Raw.find(params[:id])
    rawcla = Rawclass.new
    rawcla.id = raw.id
    rawcla.pinyin = raw.pinyin
    rawcla.name = raw.name
    rawcla.spec = raw.spec
    rawcla.unit = raw.unit
    rawdepot = Rawdepot.where('raw_id = ?',raw.id).first
    rawcla.depotnumber = rawdepot.number
    rawcla.price = rawdepot.price

    render json:rawcla
  end

  def changeinworkdetail
    if params[:way] =='add'
      inworkdepotdetails = Inworkdepot.find(params[:inworkdepotid]).inworkdepotdetails
      hasdepot = 0
      inworkdepotdetails.each do |f|
        if f.raw_id.to_s == params[:rawid]
          hasdepot = 1
        end
      end
      if hasdepot == 1
        localworkdepotdetail = inworkdepotdetails.where('raw_id = ?',params[:rawid]).first
        localworkdepotdetail.number += params[:number].to_f
        localworkdepotdetail.price = params[:price]
        localworkdepotdetail.sum = params[:price].to_f * params[:number].to_f
        localworkdepotdetail.save
      else
        inworkdepotdetails.create(raw_id:params[:rawid],price:params[:price],number:params[:number],sum:params[:sum])
      end
    elsif params[:way]=='edit'
      inworkdepotdetails = Inworkdepot.find(params[:inworkdepotid]).inworkdepotdetails.where('id =?',params[:rawid]).first
      inworkdepotdetails.number = params[:number].to_f
      inworkdepotdetails.price = params[:price]
      inworkdepotdetails.sum = params[:price].to_f * params[:number].to_f
      inworkdepotdetails.save
    elsif params[:way] == 'delete'
      inworkdepotdetails = Inworkdepotdetail.where('id in (?)',params[:rawid])
      inworkdepotdetails.each do |f|
        f.destroy
      end
    end
    render json: '{"status":"200"}'
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_inworkdepot
    @inworkdepot = Inworkdepot.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def inworkdepot_params
    params.require(:inworkdepot).permit(:ordernumber, :summary, :user, :isnew)
  end

end
