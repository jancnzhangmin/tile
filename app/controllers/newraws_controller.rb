class NewrawsController < ApplicationController

  before_action :set_newraw, only: [:show, :edit, :update, :destroy]
  def index
    @newraws = Newraw.all
  end

  def edit

  end

  def new
    @newraw = Newraw.new
  end

  def create
    @newraw = Newraw.new(newraw_params)
    respond_to do |format|
      if @newraw.save
        format.html { redirect_to newraws_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @newraw.update(newraw_params)
        format.html { redirect_to newraws_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @newraw }
      else
        format.html { render :edit }
        format.json { render json: @newraw.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @newraw.destroy
    respond_to do |format|
      format.html { redirect_to newraws_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_newraw
    @newraw = Newraw.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def newraw_params
    params.require(:newraw).permit(:name, :unit, :price, :pinyin, :width, :height)
  end

end
