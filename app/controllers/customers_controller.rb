class CustomersController < ApplicationController

  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  def index
    @customers = Customer.all
  end

  def edit

  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        #@good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        #@good.save
        format.html { redirect_to customers_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        #@good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        #@good.save
        format.html { redirect_to customers_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:name, :tel, :region, :sex)
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
