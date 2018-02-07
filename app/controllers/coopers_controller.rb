class CoopersController < ApplicationController

  before_action :set_cooper, only: [:show, :edit, :update, :destroy]
  def index
    @coopers = Cooper.all
  end

  def edit

  end

  def new
    @cooper = Cooper.new
  end

  def create
    @cooper = Cooper.new(cooper_params)
    respond_to do |format|
      if @cooper.save
        format.html { redirect_to coopers_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @cooper.update(cooper_params)
        format.html { redirect_to coopers_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @cooper }
      else
        format.html { render :edit }
        format.json { render json: @cooper.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @cooper.destroy
    respond_to do |format|
      format.html { redirect_to coopers_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  def show
    @cooperusers = @cooper.cooperusers
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_cooper
    @cooper = Cooper.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def cooper_params
    params.require(:cooper).permit(:name, :address, :tel, :bankdeposit, :bankaccount, :bankuser, :cooperuser, :cooperadmin, :contact, :contacttel)
  end

end
