class ColorlibsController < ApplicationController


  before_action :set_colorlib, only: [:show, :edit, :update, :destroy]
  def index
    @colorlibs = Colorlib.all
  end

  def edit

  end

  def new
    @colorlib = Colorlib.new
  end

  def create
    @colorlib = Colorlib.new(colorlib_params)
    respond_to do |format|
      if @colorlib.save
        format.html { redirect_to colorlibs_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @colorlib.update(colorlib_params)
        format.html { redirect_to colorlibs_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @colorlib }
      else
        format.html { render :edit }
        format.json { render json: @colorlib.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @colorlib.destroy
    respond_to do |format|
      format.html { redirect_to colorlibs_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  def show

  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_colorlib
    @colorlib = Colorlib.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def colorlib_params
    params.require(:colorlib).permit(:serial, :color)
  end

end
