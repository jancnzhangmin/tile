class PaymenttypesController < ApplicationController

  before_action :set_paymenttype, only: [:show, :edit, :update, :destroy]
  def index
    @paymenttypes = Paymenttype.all
  end

  def edit

  end

  def new
    @paymenttype = Paymenttype.new
  end

  def create
    @paymenttype = Paymenttype.new(paymenttype_params)
    respond_to do |format|
      if @paymenttype.save
        #@good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        #@good.save
        format.html { redirect_to paymenttypes_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @paymenttype.update(paymenttype_params)
        #@good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        #@good.save
        format.html { redirect_to paymenttypes_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @paymenttype }
      else
        format.html { render :edit }
        format.json { render json: @paymenttype.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @paymenttype.destroy
    respond_to do |format|
      format.html { redirect_to paymenttypes_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_paymenttype
    @paymenttype = Paymenttype.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def paymenttype_params
    params.require(:paymenttype).permit(:paymenttype)
  end

end
