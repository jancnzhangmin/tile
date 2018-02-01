class InsaledepotrecordsController < ApplicationController

  def index
    @insaledepotrecords = Insaledepot.where('isnew = 0')
  end

  def show
    @insaledepotrecord = Insaledepot.find(params[:id])
  end

  class Insaledepotdetailclass
    attr :id,true
    attr :sale,true
    attr :spec,true
    attr :unit,true
    attr :price,true
    attr :number,true
    attr :sum,true
  end

  def getdata
    @insaledepotdetails = Insaledepot.find(params[:insaledepotid]).insaledepotdetails
    insaledepotdetailarr = Array.new
    @insaledepotdetails.each do |f|
      insaledepotdetailcla = Insaledepotdetailclass.new
      insaledepotdetailcla.id = f.id
      insaledepotdetailcla.sale = f.sale.name
      insaledepotdetailcla.spec = f.sale.spec
      insaledepotdetailcla.unit = f.sale.unit
      insaledepotdetailcla.price = f.saleprice
      insaledepotdetailcla.number = f.salenumber
      insaledepotdetailcla.sum = f.salesum
      insaledepotdetailarr.push insaledepotdetailcla
    end
    render json:insaledepotdetailarr
  end

end
