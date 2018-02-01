class CooperusersController < ApplicationController

  def create
    cooper = Cooper.find(params[:cooper_id])
    cooperusers = cooper.cooperusers
    cooperusers.create(cooperuser_params)
    redirect_to cooper_path(cooper)
  end

  def destroy
    cooper = Cooper.find(params[:cooper_id])
    cooperuser = Cooperuser.find(params[:id])
    cooperuser.destroy
    redirect_to cooper_path(cooper)
  end


  private
# Use callbacks to share common setup or constraints between actions.


# Never trust parameters from the scary internet, only allow the white list through.
  def cooperuser_params
    params.require(:cooperuser).permit(:name, :usertype, :tel)
  end

end
