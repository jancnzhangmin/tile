class WorkdayrepotsController < ApplicationController

  def index
    @newworks = Newwork.where('isnew = 0').order('created_at desc').paginate(:page => params[:page], :per_page => 10)
    @newworkarr = Array.new
    @newworks.each do |newwork|
      newworkcla = Newworkclass.new
      newworkcla.created_at = newwork.created_at.strftime('%Y-%m-%d %H:%M:%S')
      if newwork.customer_id && newwork.customer_id != 0
        customer = Customer.find(newwork.customer_id)
        if customer
          newworkcla.customer = customer.name
          newworkcla.tel = customer.tel
          newworkcla.address = customer.region
        end
      end
      if newwork.cooper_id && newwork.cooper_id != 0
        newworkcla.cooper = Cooper.find(newwork.cooper_id).name
      end
      if newwork.designer_id && newwork.designer_id != 0
        newworkcla.designer = Designer.find(newwork.designer_id).name
      end
      if newwork.fiter_id && newwork.fiter_id != 0
        newworkcla.fiter = Fiter.find(newwork.fiter_id).name
      end
      newworkcla.ordernumber = newwork.ordernumber
      newworkcla.content = newwork.summary

      areaid = Array.new #原材料类型数量
      widthid = Array.new #加工边长类型数量
      heightid = Array.new #加工边长类型数量
      newworkdetails = newwork.newworkdetails
      newworkdetails.each do |newworkdetail|
        areaid.push newworkdetail.newraw_id
        widthid.push newworkdetail.widthtype
        heightid.push newworkdetail.heighttype
      end
      areaid.uniq!
      widtharr = widthid + heightid
      widtharr.uniq!

      productarr = Array.new
      tempricecount = 0
      temcostcount = 0
      areaid.each do |area|
        width = 0
        height = 0
        userheight= 0
        productcla = Newworkdetailclass.new
        productcla.number = 0
        userarea = 0

        newworkdetails = newwork.newworkdetails.where('newraw_id = ?',area)
        newworkdetails.each do |newworkdetail|
          productcla.number += newworkdetail.width.to_f / 1000 * newworkdetail.height.to_f / 1000 * newworkdetail.number.to_f
          userarea += (newworkdetail.width.to_f / 1000 * newworkdetail.userheight.to_f / 1000 + newworkdetail.lossarea.to_f / 1000) * newworkdetail.number.to_f
          tempricecount += newworkdetail.price.to_f * newworkdetail.number.to_f + newworkdetail.price.to_f * newworkdetail.lossarea.to_f / 1000
          temcostcount += newworkdetail.cost.to_f * newworkdetail.number.to_f
        end



        productcla.number = productcla.number.round(2)
        productcla.cost = temcostcount.round(2)
        productcla.price = tempricecount.round(2)
        productcla.name = Newraw.find(area).name
        productcla.unit = Newraw.find(area).unit
        #tempricecount += productcla.price
        productarr.push productcla
      end

      widthcla = Newworkdetailclass.new
      widthcla.number = 0
      widthid.each do |width|
        newworkdetails = newwork.newworkdetails.where('widthtype = ?',width)
        widthcla.unit = '米'
        if newwork.line && newwork.line != 0
          widthcla.cost = Preraw.find(newwork.line).cost
          widthcla.price = Preraw.find(newwork.line).price
          widthcla.name = Preraw.find(newwork.line).name
        end
        newworkdetails.each do |newworkdetail|
          if newworkdetail.widthtype == '02' || newworkdetail.widthtype == '06'
            widthcla.number += newworkdetail.width.to_f / 1000
          end
          if newworkdetail.widthtype == '03'
            widthcla.number += newworkdetail.width.to_f * 2 / 1000
          end
        end
      end
      if widthcla.number > 0
        productarr.push widthcla
      end

      heightcla = Newworkdetailclass.new
      heightcla.number = 0
      heightid.each do |height|
        newworkdetails = newwork.newworkdetails.where('heighttype = ?',height)
        heightcla.unit = '米'
        if newwork.line && newwork.line != 0
          heightcla.cost = Preraw.find(newwork.wave).cost
          heightcla.price = Preraw.find(newwork.wave).price
          heightcla.name = Preraw.find(newwork.wave).name
        end
        newworkdetails.each do |newworkdetail|
          if newworkdetail.heighttype == '04' || newworkdetail.heighttype == '06'
            heightcla.number += newworkdetail.height.to_f / 1000
          end
          if newworkdetail.heighttype == '05'
            heightcla.number += newworkdetail.height.to_f * 2 / 1000
          end
        end
      end
      if heightcla.number > 0
        productarr.push heightcla
      end


      #newworkcla.receive = tempricecount - newwork.pay.to_f

      newworkcla.products = productarr
      @newworkarr.push newworkcla
    end
    @customers = Customer.all
    @coopers = Cooper.all
  end

  class Newworkclass
    attr :created_at,true
    attr :customer,true
    attr :tel,true
    attr :cooper,true
    attr :designer,true
    attr :fiter,true
    attr :address,true
    attr :ordernumber,true
    attr :products,true
    attr :receive,true
    attr :receivedate,true
    attr :content,true
    attr :rownumber,true
  end

  class Newworkdetailclass
    attr :name,true
    attr :number,true
    attr :unit,true
    attr :cost,true
    attr :price,true
  end

end
