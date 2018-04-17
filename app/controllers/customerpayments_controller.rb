class CustomerpaymentsController < ApplicationController

  def index
    @customers = Customer.all.paginate(:page => params[:page], :per_page => 20)
  end

end
