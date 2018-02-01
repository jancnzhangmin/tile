class SuppliersController < ApplicationController

  before_action :set_supplier, only: [:show, :edit, :update, :destroy]
  def index
    @suppliers = Supplier.all
  end

  def edit

  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    respond_to do |format|
      if @supplier.save
        @supplier.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@supplier.name))
        @supplier.save
        format.html { redirect_to suppliers_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        @supplier.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@supplier.name))
        @supplier.save
        format.html { redirect_to suppliers_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def supplier_params
    params.require(:supplier).permit(:name, :address, :tel, :bankdeposit, :bankaccount, :bankuser, :amount)
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
