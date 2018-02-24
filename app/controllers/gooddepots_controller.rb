class GooddepotsController < ApplicationController

  def index
    @goods = Gooddepot.all
  end

end
