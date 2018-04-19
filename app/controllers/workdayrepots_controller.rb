class WorkdayrepotsController < ApplicationController

  def index
    @newworks = Newwork.where('isnew = 0')
    if params[:searchordernumber].to_s != ''
      @newworks = @newworks.where('ordernumber like ?',"%#{params[:searchordernumber]}%")
    end
    if params[:searchstartdate].to_s != ''
      @newworks = @newworks.where('created_at >= ?',"#{params[:searchstartdate]}")
    end
    if params[:searchenddate].to_s != ''
      @newworks = @newworks.where('created_at <= ?',"#{params[:searchenddate]}")
    end
    if params[:searchcustomer].to_s != ''
      customer = Customer.where('name like ?',"%#{params[:searchcustomer]}%")
      @newworks = @newworks.where('customer_id in (?)',customer.ids)
    end
    if params[:searchtel].to_s != ''
      customer = Customer.where('tel like ?',"%#{params[:searchtel]}%")
      @newworks = @newworks.where('customer_id in (?)',customer.ids)
    end
    if params[:searchcooper].to_s != ''
      cooper = Cooper.where('name like ?',"%#{params[:searchcooper]}%")
      @newworks = @newworks.where('cooper_id in (?)',cooper.ids)
    end
    if params[:searchdesigner].to_s != ''
      designer = Designer.where('name like ?',"%#{params[:searchdesigner]}%")
      @newworks = @newworks.where('designer_id in (?)',designer.ids)
    end
    if params[:searchfiter].to_s != ''
      fiter = Fiter.where('name like ?',"%#{params[:searchfiter]}%")
      @newworks = @newworks.where('fiter_id in (?)',fiter.ids)
    end
    @newworks = @newworks.order('created_at desc').paginate(:page => params[:page], :per_page => 10)
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

  def getmonth
    date = params[:date].to_s
    if date == ''
      date = Time.now.strftime('%Y-%m')
    end
    month = Array.new
    companyprice = Array.new
    customerprice = Array.new
    companyraw = Array.new
    customerraw = Array.new
    companywork = Array.new
    customerwork = Array.new
    Time.parse(date+'-01').end_of_month.day.times do |tice|
      month.push tice + 1
      temday = (tice+1).to_s
      if temday.length == 1
        temday = '0'+temday
      end
      datestr = "%#{date+'-'+temday}%"
      #deposit.push Deposit.where('created_at like ?',datestr).sum('amount')
      temcompanyraw = 0
      temcustomerraw = 0
      temcompanywork = 0
      temcustomerwork = 0
      newworks = Newwork.where('created_at like ? and isnew = 0',datestr)
      newworks.each do |newwork|
        linecost = 0
        if newwork.line && newwork.line != 0
          prerawline = Preraw.find(newwork.line)
          if prerawline
            linecost = prerawline.cost.to_f
          end
        end
        lineprice = 0
        if newwork.line && newwork.line != 0
          prerawline = Preraw.find(newwork.line)
          if prerawline
            lineprice = prerawline.price.to_f
          end
        end
        wavecost = 0
        if newwork.wave && newwork.wave != 0
          prerawwave = Preraw.find(newwork.wave)
          if prerawwave
            wavecost = prerawline.cost.to_f
          end
        end
        waveprice = 0
        if newwork.wave && newwork.wave != 0
          prerawwave = Preraw.find(newwork.wave)
          if prerawwave
            waveprice = prerawline.price.to_f
          end
        end
        newworkdetails = newwork.newworkdetails
        newworkdetails.each do |newworkdetail|
          newdepot = Newdepot.find_by(id:newworkdetail.newraw_id)
          rawcost = 0
          if newdepot
            rawcost = Newdepot.find(newworkdetail.newraw_id).price
          end
          newraw = Newraw.find_by(id:newworkdetail.newraw_id)
          rawprice = 0
          if newraw
            rawprice = Newraw.find(newworkdetail.newraw_id).price
          end
          temcompanyraw += newworkdetail.width.to_f / 1000 * newworkdetail.height.to_f / 1000 * newworkdetail.number * rawcost.to_f
          temcustomerraw += (newworkdetail.width.to_f / 1000 * newworkdetail.height.to_f / 1000 + newworkdetail.lossarea.to_f) * newworkdetail.number * rawprice.to_f
          if newworkdetail.widthtype == '02'
            temcompanywork += newworkdetail.width.to_f / 1000 * linecost
            temcustomerwork += newworkdetail.width.to_f / 1000 * lineprice
          end
          if newworkdetail.widthtype == '03'
            temcompanywork += newworkdetail.width.to_f / 1000 * linecost * 2
            temcustomerwork += newworkdetail.width.to_f / 1000 * lineprice * 2
          end
          if newworkdetail.widthtype == '04'
            temcompanywork += newworkdetail.width.to_f / 1000 * wavecost
            temcustomerwork += newworkdetail.width.to_f / 1000 * waveprice
          end
          if newworkdetail.widthtype == '05'
            temcompanywork += newworkdetail.width.to_f / 1000 * wavecost * 2
            temcustomerwork += newworkdetail.width.to_f / 1000 * waveprice * 2
          end
          if newworkdetail.widthtype == '06'
            temcompanywork += newworkdetail.width.to_f / 1000 * linecost
            temcustomerwork += newworkdetail.width.to_f / 1000 * lineprice
            temcompanywork += newworkdetail.width.to_f / 1000 * wavecost
            temcustomerwork += newworkdetail.width.to_f / 1000 * waveprice
          end
          if newworkdetail.heighttype == '02'
            temcompanywork += newworkdetail.height.to_f / 1000 * linecost
            temcustomerwork += newworkdetail.height.to_f / 1000 * lineprice
          end
          if newworkdetail.heighttype == '03'
            temcompanywork += newworkdetail.height.to_f / 1000 * linecost * 2
            temcustomerwork += newworkdetail.height.to_f / 1000 * lineprice * 2
          end
          if newworkdetail.heighttype == '04'
            temcompanywork += newworkdetail.height.to_f / 1000 * wavecost
            temcustomerwork += newworkdetail.height.to_f / 1000 * waveprice
          end
          if newworkdetail.heighttype == '05'
            temcompanywork += newworkdetail.height.to_f / 1000 * wavecost * 2
            temcustomerwork += newworkdetail.height.to_f / 1000 * waveprice * 2
          end
          if newworkdetail.heighttype == '06'
            temcompanywork += newworkdetail.height.to_f / 1000 * linecost
            temcustomerwork += newworkdetail.height.to_f / 1000 * lineprice
            temcompanywork += newworkdetail.height.to_f / 1000 * wavecost
            temcustomerwork += newworkdetail.height.to_f / 1000 * waveprice
          end
        end
      end
      companyprice.push (temcompanyraw + temcompanywork).round(2)
      customerprice.push (temcustomerraw + temcustomerwork).round(2)
      companyraw.push temcompanyraw.round(2)
      customerraw.push temcustomerraw.round(2)
      companywork.push temcompanywork.round(2)
      customerwork.push temcustomerwork.round(2)
    end
    render json: '{"date":'+date.to_json+',"month":'+month.to_json+',"companyprice":'+companyprice.to_json+',"customerprice":'+customerprice.to_json+',"companyraw":'+companyraw.to_json+',"customerraw":'+customerraw.to_json+',"companywork":'+companywork.to_json+',"customerwork":'+customerwork.to_json+'}'
  end

  def getyear
    date = params[:date].to_s
    if date == ''
      date = Time.now.strftime('%Y')
    end
    month = Array.new
    companyprice = Array.new
    customerprice = Array.new
    companyraw = Array.new
    customerraw = Array.new
    companywork = Array.new
    customerwork = Array.new
    12.times do |tice|
      month.push (tice + 1).to_s+'月'
      temday = (tice+1).to_s
      if temday.length == 1
        temday = '0'+temday
      end
      datestr = "%#{date+'-'+temday}%"
      #deposit.push Deposit.where('created_at like ?',datestr).sum('amount')
      temcompanyraw = 0
      temcustomerraw = 0
      temcompanywork = 0
      temcustomerwork = 0
      newworks = Newwork.where('created_at like ? and isnew = 0',datestr)
      newworks.each do |newwork|
        linecost = 0
        if newwork.line && newwork.line != 0
          prerawline = Preraw.find(newwork.line)
          if prerawline
            linecost = prerawline.cost.to_f
          end
        end
        lineprice = 0
        if newwork.line && newwork.line != 0
          prerawline = Preraw.find(newwork.line)
          if prerawline
            lineprice = prerawline.price.to_f
          end
        end
        wavecost = 0
        if newwork.wave && newwork.wave != 0
          prerawwave = Preraw.find(newwork.wave)
          if prerawwave
            wavecost = prerawline.cost.to_f
          end
        end
        waveprice = 0
        if newwork.wave && newwork.wave != 0
          prerawwave = Preraw.find(newwork.wave)
          if prerawwave
            waveprice = prerawline.price.to_f
          end
        end
        newworkdetails = newwork.newworkdetails
        newworkdetails.each do |newworkdetail|
          newdepot = Newdepot.find_by(id:newworkdetail.newraw_id)
          rawcost = 0
          if newdepot
            rawcost = Newdepot.find(newworkdetail.newraw_id).price
          end
          newraw = Newraw.find_by(id:newworkdetail.newraw_id)
          rawprice = 0
          if newraw
            rawprice = Newraw.find(newworkdetail.newraw_id).price
          end
          temcompanyraw += newworkdetail.width.to_f / 1000 * newworkdetail.height.to_f / 1000 * newworkdetail.number * rawcost.to_f
          temcustomerraw += (newworkdetail.width.to_f / 1000 * newworkdetail.height.to_f / 1000 + newworkdetail.lossarea.to_f) * newworkdetail.number * rawprice.to_f
          if newworkdetail.widthtype == '02'
            temcompanywork += newworkdetail.width.to_f / 1000 * linecost
            temcustomerwork += newworkdetail.width.to_f / 1000 * lineprice
          end
          if newworkdetail.widthtype == '03'
            temcompanywork += newworkdetail.width.to_f / 1000 * linecost * 2
            temcustomerwork += newworkdetail.width.to_f / 1000 * lineprice * 2
          end
          if newworkdetail.widthtype == '04'
            temcompanywork += newworkdetail.width.to_f / 1000 * wavecost
            temcustomerwork += newworkdetail.width.to_f / 1000 * waveprice
          end
          if newworkdetail.widthtype == '05'
            temcompanywork += newworkdetail.width.to_f / 1000 * wavecost * 2
            temcustomerwork += newworkdetail.width.to_f / 1000 * waveprice * 2
          end
          if newworkdetail.widthtype == '06'
            temcompanywork += newworkdetail.width.to_f / 1000 * linecost
            temcustomerwork += newworkdetail.width.to_f / 1000 * lineprice
            temcompanywork += newworkdetail.width.to_f / 1000 * wavecost
            temcustomerwork += newworkdetail.width.to_f / 1000 * waveprice
          end
          if newworkdetail.heighttype == '02'
            temcompanywork += newworkdetail.height.to_f / 1000 * linecost
            temcustomerwork += newworkdetail.height.to_f / 1000 * lineprice
          end
          if newworkdetail.heighttype == '03'
            temcompanywork += newworkdetail.height.to_f / 1000 * linecost * 2
            temcustomerwork += newworkdetail.height.to_f / 1000 * lineprice * 2
          end
          if newworkdetail.heighttype == '04'
            temcompanywork += newworkdetail.height.to_f / 1000 * wavecost
            temcustomerwork += newworkdetail.height.to_f / 1000 * waveprice
          end
          if newworkdetail.heighttype == '05'
            temcompanywork += newworkdetail.height.to_f / 1000 * wavecost * 2
            temcustomerwork += newworkdetail.height.to_f / 1000 * waveprice * 2
          end
          if newworkdetail.heighttype == '06'
            temcompanywork += newworkdetail.height.to_f / 1000 * linecost
            temcustomerwork += newworkdetail.height.to_f / 1000 * lineprice
            temcompanywork += newworkdetail.height.to_f / 1000 * wavecost
            temcustomerwork += newworkdetail.height.to_f / 1000 * waveprice
          end
        end
      end
      companyprice.push (temcompanyraw + temcompanywork).round(2)
      customerprice.push (temcustomerraw + temcustomerwork).round(2)
      companyraw.push temcompanyraw.round(2)
      customerraw.push temcustomerraw.round(2)
      companywork.push temcompanywork.round(2)
      customerwork.push temcustomerwork.round(2)
    end
    render json: '{"date":'+date.to_json+',"month":'+month.to_json+',"companyprice":'+companyprice.to_json+',"customerprice":'+customerprice.to_json+',"companyraw":'+companyraw.to_json+',"customerraw":'+customerraw.to_json+',"companywork":'+companywork.to_json+',"customerwork":'+customerwork.to_json+'}'
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
