class SalesController < ApplicationController

  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  def index
    @sales = Sale.all
    @preorders = Preorder.where('isnew = 0')
  end

  def edit

  end

  def new
    @sale = Sale.create(isnew:1)
    redirect_to edit_sale_path(@sale)
  end

  def create
    @sale = Sale.new(sale_params)
    respond_to do |format|
      if @sale.save
        @sale.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@sale.name))
        @sale.save
        format.html { redirect_to sales_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @sale.update(sale_params)
        @sale.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@sale.name))
        @sale.save
        format.html { redirect_to sales_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  class Saledetailclass
    attr :id,true
    attr :raw,true
    attr :spec,true
    attr :unit,true
    attr :cost,true
    attr :price,true
    attr :number,true
  end

  def getdata
    @saledetails = Sale.find(params[:saleid]).saledetails
    saledetailarr = Array.new
    @saledetails.each do |f|
      saledetailcla = Saledetailclass.new
      saledetailcla.id = f.id
      saledetailcla.raw = f.raw.name
      saledetailcla.spec = f.raw.spec
      saledetailcla.unit = f.raw.unit
      saledetailcla.cost = f.raw.price
      saledetailcla.number = f.number
      saledetailcla.sum = f.sum
      saledetailarr.push saledetailcla
    end
    render json:saledetailarr
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
    raws = Raw.all
    rawarr = Array.new
    raws.each do |f|
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

  private
# Use callbacks to share common setup or constraints between actions.
  def set_sale
    @sale = Sale.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def sale_params
    params.require(:sale).permit(:name, :spec, :unit, :price, :cost, :pinyin)
  end

  def safestring(str)
    mystr =""
    str.each_byte  do |byte|
      if (byte > 47 && byte < 58) || (byte > 96 && byte < 123)
        mystr+=byte.chr
      end
    end
    return mystr
  end

end
