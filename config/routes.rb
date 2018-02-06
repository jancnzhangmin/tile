Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    collection do
      get 'checklogin'

    end
    member do
      get 'auth'
      get 'saveauth'
    end
  end
  resources :compans
  resources :suppliers
  resources :raws
  resources :inrawdepots do
    collection do
      get 'getdata'
      get 'getsupplier'
      get 'getraw'
      get 'getrawbyid'
      get 'changeinrawdetail'
    end
  end

  resources :newraws
  resources :innewraws do
    collection do
      get 'getsupplier'
      get 'getdata'
      get 'getraw'
      get 'changeinrawdetail'
      get 'deleteinrawdetail'
    end
  end
  resources :newdepots do

  end
  resources :preorders do
    collection do
      get 'getdata'
      get 'getpreraw'
      get 'changeinrawdetail'
      get 'deleteinrawdetail'
      get 'work'
      get 'getcooperuser'
    end
    member do
      get 'dowork'
    end
  end

  resources :rawdepots
  resources :inrawdepotrecords do
    collection do
      get 'getdata'
    end
  end
  resources :inworkdepots do
    collection do
      get 'getdata'
      get 'getsupplier'
      get 'getraw'
      get 'getrawbyid'
      get 'changeinworkdetail'
    end
  end
  resources :inworkdepotdetails do
    collection do
      get 'getdata'
    end
  end
  resources :inworkdepotrecords do
    collection do
      get 'getdata'
    end
  end
  resources :workdepots
  resources :sales do
    collection do
      get 'getdata'
      get 'getraw'
    end
  end
  resources :saledepots
  resources :insaledepots do
    collection do
      get 'getdata'
      get 'getsale'
      get 'getsalebyid'
      get 'changeinsaledetail'
      get 'getwork'
      get 'getworkbyid'
    end
  end
  resources :insaledepotrecords do
    collection do
      get 'getdata'
    end
  end
  resources :goods
  resources :gooddepots
  resources :ingooddepots do
    collection do
      get 'getdata'
      get 'getgood'
      get 'getgoodbyid'
      get 'changeingooddetail'
    end
  end
  resources :ingooddepotrecords do
    collection do
      get 'getdata'
    end
  end
  resources :customers
  resources :reserves do
    collection do
      get 'getdata'
      get 'getcustomer'
      get 'getsale'
      get 'getsalebyid'
      get 'changereserve'
      get 'trans'
    end
  end
  resources :reservedetails
  resources :saleres do
    collection do
      get 'getdata'
      get 'getcustomer'
      get 'getsale'
      get 'getsalebyid'
      get 'changesalere'
    end
  end
  resources :saleredetails
  resources :workattchs
  resources :workatts
  resources :coopers do
    resources :cooperusers
  end
  resources :preraws

  resources :newworks do
    collection do
      get 'getdata'
      get 'getpreraw'
      get 'changenewworkdetail'
      get 'deleteinrawdetail'
      get 'work'
      get 'getcooperuser'
      get 'getrawbyid'
      get 'gettotal'
    end
    member do
      get 'worklian'
    end
  end
  resources :workrecords


end