class ReservedetailsController < ApplicationController

  def create

    @reserve = Reserve.find(params[:reserf_id])
    @reservedetails = @reserve.reservedetails.create(reservedetails_params)
    redirect_to user_path(@user)
  end

  private

  def reservedetails_params
    params.require(:reservedetail).permit(:sale_id,:number)
  end

end
