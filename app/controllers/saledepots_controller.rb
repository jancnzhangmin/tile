class SaledepotsController < ApplicationController

  def index
    @saledepots = Saledepot.all
  end

end
