class WorkdepotsController < ApplicationController

  def index
    @workdepots = Workdepot.all
    @width = @workdepots.sum('width') / 1000 * @workdepots.sum('height') / 1000 * @workdepots.sum('price') * @workdepots.sum('number')
    @userheight = @workdepots.sum('width') / 1000 * @workdepots.sum('userheight') / 1000 * @workdepots.sum('price') * @workdepots.sum('number')
  end

end
