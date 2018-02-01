class InrawdepotrecordsController < ApplicationController

  def index
    @inrawdepotrecords = Inrawdepot.where('isnew = 0')
  end

  def show
    @inrawdepotrecord = Inrawdepot.find(params[:id])
  end

  class Inrawdepotdetailclass
    attr :id,true
    attr :raw,true
    attr :spec,true
    attr :unit,true
    attr :price,true
    attr :number,true
    attr :sum,true
  end

  def getdata
    @inrawdepotdetails = Inrawdepot.find(params[:inrawdepotid]).inrawdepotdetails
    inrawdepotdetailarr = Array.new
    @inrawdepotdetails.each do |f|
      inrawdepotdetailcla = Inrawdepotdetailclass.new
      inrawdepotdetailcla.id = f.id
      inrawdepotdetailcla.raw = f.raw.name
      inrawdepotdetailcla.spec = f.raw.spec
      inrawdepotdetailcla.unit = f.raw.unit
      inrawdepotdetailcla.price = f.price
      inrawdepotdetailcla.number = f.number
      inrawdepotdetailcla.sum = f.sum
      inrawdepotdetailarr.push inrawdepotdetailcla
    end
    render json:inrawdepotdetailarr
  end

end
