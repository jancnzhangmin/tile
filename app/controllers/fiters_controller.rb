class FitersController < ApplicationController

  before_action :set_fiter, only: [:show, :edit, :update, :destroy]
  def index
    @fiters = Fiter.all
  end

  def edit

  end

  def new
    @fiter = Fiter.new
  end

  def create
    @fiter = Fiter.new(fiter_params)
    respond_to do |format|
      if @fiter.save
        #@good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        #@good.save
        format.html { redirect_to fiters_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @fiter.update(fiter_params)
        #@good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        #@good.save
        format.html { redirect_to fiters_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @fiter }
      else
        format.html { render :edit }
        format.json { render json: @fiter.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @fiter.destroy
    respond_to do |format|
      format.html { redirect_to fiters_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_fiter
    @fiter = Fiter.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def fiter_params
    params.require(:fiter).permit(:name, :tel)
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
