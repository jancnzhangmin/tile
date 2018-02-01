class InworkdepotrecordsController < ApplicationController

  def index
    @inworkdepotrecords = Inworkdepot.where('isnew = 0')
  end

  def show
    @inworkdepotrecord = Inworkdepot.find(params[:id])
  end

  class Inworkdepotdetailclass
    attr :id,true
    attr :raw,true
    attr :spec,true
    attr :unit,true
    attr :price,true
    attr :number,true
    attr :sum,true
  end

  def getdata
    @inworkdepotdetails = Inworkdepot.find(params[:inworkdepotid]).inworkdepotdetails
    inworkdepotdetailarr = Array.new
    @inworkdepotdetails.each do |f|
      inworkdepotdetailcla = Inworkdepotdetailclass.new
      inworkdepotdetailcla.id = f.id
      inworkdepotdetailcla.raw = f.raw.name
      inworkdepotdetailcla.spec = f.raw.spec
      inworkdepotdetailcla.unit = f.raw.unit
      inworkdepotdetailcla.price = f.price
      inworkdepotdetailcla.number = f.number
      inworkdepotdetailcla.sum = f.sum
      inworkdepotdetailarr.push inworkdepotdetailcla
    end
    render json:inworkdepotdetailarr
  end

end
