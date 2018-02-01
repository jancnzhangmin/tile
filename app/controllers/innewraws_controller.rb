class InnewrawsController < ApplicationController

  before_action :set_innewraw, only: [:show, :edit, :update, :destroy]
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
    @inrawdepot = Innewraw.create(ordernumber:ordernumber,isnew:1)
    redirect_to edit_innewraw_path(@inrawdepot)
  end

  def edit

  end

  def new
    @inrawdepot = Inrawdepot.new
  end

  def create
    @innewraw = User.new(inrawdepot_params)

    respond_to do |format|
      if @innewraw.save
        format.html { redirect_to inrawdepots_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @innewraw.isnew = 0
      if @innewraw.update(innewraw_params)

        if @innewraw.pay.to_s != ''
          supplier = Supplier.find(@innewraw.supplier_id)
          supplier.supplierpayments.create(pay:@innewraw.pay,summary:'支付'+@innewraw.ordernumber+'订单的采购款')
        end

        innewdepotdetails = @innewraw.innewdepotdetails
        innewdepotdetails.each do |f|
          newdepot = Newdepot.where('newraw_id = ?',f.newraw_id).first
          if newdepot
            #firstrawdepot.price = (f.price * f.number + firstrawdepot.price * firstrawdepot.number) / (f.number + firstrawdepot.number)
            newdepotdetails = newdepot.newdepotdetails.where('width = ? and height = ?',f.width,f.height)
            newdepotdetail = newdepot.newdepotdetails.where('width = ? and height = ?',f.width,f.height).first
            if newdepotdetail
              newdepotdetail.price = (newdepotdetail.price * newdepotdetail.number + f.price * f.number) / (newdepotdetail.number + f.number)
              newdepotdetail.number += f.number
              newdepotdetail.save
            else
              newdepotdetails.create(width:f.width,height:f.height,price:f.price,number:f.number)
            end
          else
            newdepot = Newdepot.create(newraw_id:f.newraw_id)
            newdepotdetails = newdepot.newdepotdetails.create(width:f.width,height:f.height,price:f.price,number:f.number)
          end

        end


        inrawdepotdetails = Innewraw.find(params[:inrawdepotid]).innewdepotdetails
        hasdepot = 0
        inrawdepotdetails.each do |f|
          if f.newraw_id.to_s == params[:rawid] && f.width == params[:width].to_f && f.height == params[:height].to_f
            hasdepot = 1
          end
        end
        if hasdepot == 1
          localrawdepotdetail = inrawdepotdetails.where('newraw_id = ? and width = ? and height = ?',params[:rawid],params[:width],params[:height]).first
          localrawdepotdetail.number += params[:number].to_f
          localrawdepotdetail.price = params[:price]
          localrawdepotdetail.sum = params[:price].to_f * localrawdepotdetail.number
          localrawdepotdetail.save
        else
          inrawdepotdetails.create(newraw_id:params[:rawid],price:params[:price],width:params[:width],height:params[:height],number:params[:number],sum:params[:sum])
        end




        format.html { redirect_to newdepots_path, notice: 'User was successfully updated.' }
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
    attr :width,true
    attr :height,true
    attr :raw_id,true
  end

  def getdata
    @innewdepotdetails = Innewraw.find(params[:inrawdepotid]).innewdepotdetails
    inrawdepotdetailarr = Array.new
    @innewdepotdetails.each do |f|
      inrawdepotdetailcla = Inrawdepotdetailclass.new
      newraw = Newraw.find(f.newraw_id)
      inrawdepotdetailcla.id = f.id
      inrawdepotdetailcla.raw_id = f.newraw_id
      inrawdepotdetailcla.raw = newraw.name
      inrawdepotdetailcla.width = f.width
      inrawdepotdetailcla.height = f.height
      inrawdepotdetailcla.unit = newraw.unit
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
    raws = Newraw.all
    rawarr = Array.new
    raws.each do |f|
      rawcla = Rawclass.new
      rawcla.id = f.id
      rawcla.pinyin = f.pinyin
      rawcla.name = f.name
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
      inrawdepotdetails = Innewraw.find(params[:inrawdepotid]).innewdepotdetails

      hasdepot = 0
      inrawdepotdetails.each do |f|

        if f.newraw_id.to_s == params[:rawid] && f.width == params[:width].to_f && f.height == params[:height].to_f
          hasdepot = 1
        end
      end
      if hasdepot == 1
        localrawdepotdetail = inrawdepotdetails.where('newraw_id = ? and width = ? and height = ?',params[:rawid],params[:width],params[:height]).first
        localrawdepotdetail.number += params[:number].to_f
        localrawdepotdetail.price = params[:price]
        localrawdepotdetail.sum = params[:price].to_f * localrawdepotdetail.number
        localrawdepotdetail.save
      else
        inrawdepotdetails.create(newraw_id:params[:rawid],price:params[:price],width:params[:width],height:params[:height],number:params[:number],sum:params[:sum])
      end
    elsif params[:way]=='edit'
      inrawdepotdetails = Innewdepotdetail.where('id =?',params[:rawid]).first
      inrawdepotdetails.width = params[:width]
      inrawdepotdetails.height = params[:height]
      inrawdepotdetails.number = params[:number].to_f
      inrawdepotdetails.price = params[:price]
      inrawdepotdetails.sum = params[:price].to_f * params[:number].to_f
      inrawdepotdetails.save
    end
    render json: '{"status":"200"}'
  end

  def deleteinrawdetail
    params[:ids].each do |f|
      inrawdepot = Innewdepotdetail.find(f)
      inrawdepot.destroy
    end
    render json: '{"status":"200"}'
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_innewraw
    @innewraw = Innewraw.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def innewraw_params
    params.require(:innewraw).permit(:ordernumber, :summary, :supplier_id, :isnew, :pay, :user)
  end

end
