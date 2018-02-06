# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180206082400) do

  create_table "add_cooperuser_to_coopers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cooperuser"
    t.string "cooperadmin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "add_password_to_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "compans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "address"
    t.string "tel"
    t.string "bankdeposit"
    t.string "bankaccount"
    t.string "bankuser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cooperdetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "contact"
    t.string "ctype"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cooper_id"
  end

  create_table "coopers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "address"
    t.string "tel"
    t.string "bankdeposit"
    t.string "bankaccount"
    t.string "bankuser"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cooperuser"
    t.string "cooperadmin"
  end

  create_table "cooperusers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "cooper_id"
    t.string "name"
    t.string "tel"
    t.string "usertype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "tel"
    t.string "region"
  end

  create_table "designers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fiters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gooddepots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "good_id"
    t.float "number", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "spec"
    t.string "unit"
    t.string "pinyin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingooddepotdetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "ingooddepot_id"
    t.integer "good_id"
    t.float "number", limit: 24
    t.string "sum"
    t.string "float"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingooddepots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ordernumber"
    t.text "summary"
    t.string "user"
    t.integer "isnew"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "innewdepotdetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "innewdepot_id"
    t.integer "newraw_id"
    t.float "price", limit: 24
    t.float "number", limit: 24
    t.float "sum", limit: 24
    t.float "width", limit: 24
    t.float "height", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "innewraw_id"
    t.string "summary"
  end

  create_table "innewraws", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ordernumber"
    t.text "summary"
    t.string "user"
    t.integer "isnew"
    t.integer "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "pay", limit: 24
  end

  create_table "inrawdepotdetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "inrawdepot_id"
    t.integer "supplier_id"
    t.integer "raw_id"
    t.float "price", limit: 24
    t.float "number", limit: 24
    t.float "sum", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "innewraw_id"
  end

  create_table "inrawdepots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ordernumber"
    t.text "summary"
    t.string "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "isnew"
    t.integer "supplier_id"
  end

  create_table "insaledepotdetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "insaledepot_id"
    t.integer "raw_id"
    t.float "rawprice", limit: 24
    t.float "rawnumber", limit: 24
    t.integer "sale_id"
    t.float "saleprice", limit: 24
    t.float "salenumber", limit: 24
    t.float "salesum", limit: 24
    t.float "rawsum", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insaledepots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ordernumber"
    t.string "user"
    t.string "summary"
    t.integer "isnew"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inworkdepotdetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "inworkdepot_id"
    t.integer "raw_id"
    t.float "price", limit: 24
    t.float "number", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "sum", limit: 24
  end

  create_table "inworkdepots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ordernumber"
    t.string "user"
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "isnew"
    t.string "preordernumber"
  end

  create_table "newdepotdetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "newdepot_id"
    t.float "width", limit: 24
    t.float "height", limit: 24
    t.float "price", limit: 24
    t.float "number", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "newdepots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "newraw_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price", limit: 24
    t.float "number", limit: 24
  end

  create_table "newraws", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "unit"
    t.string "price"
    t.string "pinyin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "width", limit: 24
    t.float "height", limit: 24
  end

  create_table "newrawspecs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "newraw_id"
    t.float "width", limit: 24
    t.float "height", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "cost", limit: 24
    t.float "number", limit: 24
  end

  create_table "newworkdetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "newwork_id"
    t.integer "newraw_id"
    t.float "width", limit: 24
    t.float "height", limit: 24
    t.float "userheight", limit: 24
    t.string "widthtype"
    t.string "heighttype"
    t.float "number", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "newworks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ordernumber"
    t.string "user"
    t.string "summary"
    t.integer "isnew"
    t.string "preordernumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preorderdetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "preorder_id"
    t.integer "newraw_id"
    t.float "width", limit: 24
    t.float "height", limit: 24
    t.float "sum", limit: 24
    t.string "area"
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "preraw_id"
    t.float "price", limit: 24
    t.float "number", limit: 24
    t.string "unit"
    t.integer "cooper_id"
    t.integer "cooperuser_id"
    t.float "userheight", limit: 24
    t.string "rawtype"
  end

  create_table "preorders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "newraw_id"
    t.float "pay", limit: 24
    t.string "user"
    t.integer "isnew"
    t.string "ordernumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "installdate"
    t.integer "cooper_id"
    t.integer "cooperuser_id"
    t.string "address"
    t.integer "customer_id"
    t.integer "designer_id"
    t.integer "fiter_id"
  end

  create_table "preraws", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "pinyin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rawdepots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "address"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "raw_id"
    t.float "number", limit: 24
    t.float "price", limit: 24
  end

  create_table "raws", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "spec"
    t.string "unit"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "cost", limit: 24
    t.string "pinyin"
    t.float "width", limit: 24
    t.float "height", limit: 24
  end

  create_table "reservedetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "number", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reserve_id"
    t.integer "sale_id"
    t.float "sum", limit: 24
  end

  create_table "reserves", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "customer_id"
    t.string "ordernumber"
    t.datetime "orderdate"
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "isnew"
    t.integer "status"
    t.string "user"
    t.float "pay", limit: 24
  end

  create_table "saledepots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "sale_id"
    t.float "number", limit: 24
    t.float "price", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saledetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "raw_id"
    t.integer "sale_id"
    t.float "number", limit: 24
    t.float "price", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saleredetails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "sale_id"
    t.float "number", limit: 24
    t.float "price", limit: 24
    t.float "sum", limit: 24
    t.integer "salere_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saleres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "customer_id"
    t.string "ordernumber"
    t.text "summary"
    t.string "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "isnew"
  end

  create_table "sales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "spec"
    t.string "unit"
    t.float "cost", limit: 24
    t.float "price", limit: 24
    t.string "pinyin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "isnew"
  end

  create_table "supplierpayments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "supplier_id"
    t.float "pay", limit: 24
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "address"
    t.string "tel"
    t.string "bankdeposit"
    t.string "bankaccount"
    t.string "bankuser"
    t.float "amount", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pinyin"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "idcard"
    t.integer "sex"
    t.string "tel"
    t.datetime "entrydate"
    t.datetime "quitdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.string "login"
    t.string "password_digest"
    t.text "auth"
  end

  create_table "workattches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "fa"
    t.string "pinyin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workatts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "fa"
    t.string "pinyin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workdepots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "raw_id"
    t.float "price", limit: 24
    t.float "number", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "newraw_id"
    t.float "width", limit: 24
    t.float "height", limit: 24
    t.float "userheight", limit: 24
  end

  create_table "workrecords", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "newraw_id"
    t.integer "newwork_id"
    t.float "width", limit: 24
    t.float "height", limit: 24
    t.float "userheight", limit: 24
    t.float "price", limit: 24
    t.float "number", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "worknumber"
  end

end
