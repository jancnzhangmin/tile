class GoodsController < ApplicationController

  before_action :set_good, only: [:show, :edit, :update, :destroy]
  def index
    @goods = Good.all
  end

  def edit

  end

  def new
    @good = Good.new
  end

  def create
    @good = Good.new(good_params)
    respond_to do |format|
      if @good.save
        @good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        @good.save
        format.html { redirect_to goods_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @good.update(good_params)
        @good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        @good.save
        format.html { redirect_to goods_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @good }
      else
        format.html { render :edit }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @good.destroy
    respond_to do |format|
      format.html { redirect_to goods_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_good
    @good = Good.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def good_params
    params.require(:good).permit(:name, :spec, :unit, :unit)
  end

  def safestring(str)
    mystr =""
    str.each_byte  do |byte|
      if (byte > 47 && byte < 58) || (byte > 96 && byte < 123)
        mystr+=byte.chr
      end
    end
    return mystr
  end

end
