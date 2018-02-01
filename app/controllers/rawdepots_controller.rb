class RawdepotsController < ApplicationController

  def index
    @rawdepots = Rawdepot.all
  end

end
