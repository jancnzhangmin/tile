class CompansController < ApplicationController

  before_action :set_compan, only: [:show, :edit, :update, :destroy]
  def index
    @compan = Compan.first
    if @compan
      redirect_to edit_compan_path(@compan)
    else
      @compan = Compan.create(name:'')
      redirect_to edit_compan_path(@compan)
    end
  end

  def edit

  end





  def update
    respond_to do |format|
      if @compan.update(compan_params)
        flash[:success] = "公司信息已成功保存"
        format.html { redirect_to edit_compan_path(@compan)}
        format.json { render :show, status: :ok, location: @compan }
      else
        format.html { render :edit }
        format.json { render json: @compan.errors, status: :unprocessable_entity }
      end
    end

  end




  private
# Use callbacks to share common setup or constraints between actions.
  def set_compan
    @compan = Compan.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def compan_params
    params.require(:compan).permit(:name, :address, :tel, :bankdeposit, :bankaccount, :bankuser)
  end

end
