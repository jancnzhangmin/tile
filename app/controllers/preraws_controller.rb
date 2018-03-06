class PrerawsController < ApplicationController

  before_action :set_preraw, only: [:show, :edit, :update, :destroy]
  def index
    @preraws = Preraw.all
  end

  def edit

  end

  def new
    @preraw = Preraw.new
  end

  def create
    @preraw = Preraw.new(preraw_params)
    respond_to do |format|
      if @preraw.save
        format.html { redirect_to preraws_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @preraw.update(preraw_params)
        format.html { redirect_to preraws_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @preraw }
      else
        format.html { render :edit }
        format.json { render json: @preraw.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @preraw.destroy
    respond_to do |format|
      format.html { redirect_to preraws_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_preraw
    @preraw = Preraw.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def preraw_params
    params.require(:preraw).permit(:name,:price, :unit, :cost)
  end

end
