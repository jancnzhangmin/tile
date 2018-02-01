class RawsController < ApplicationController

  before_action :set_raw, only: [:show, :edit, :update, :destroy]
  def index
    @raws = Raw.all
  end

  def edit

  end

  def new
    @raw = Raw.new
  end

  def create
    @raw = Raw.new(raw_params)
    respond_to do |format|
      if @raw.save
        @raw.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@raw.name))
        @raw.save
        format.html { redirect_to raws_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @raw.update(raw_params)
        @raw.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@raw.name))
        @raw.save
        format.html { redirect_to raws_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @raw }
      else
        format.html { render :edit }
        format.json { render json: @raw.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @raw.destroy
    respond_to do |format|
      format.html { redirect_to raws_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_raw
    @raw = Raw.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def raw_params
    params.require(:raw).permit(:name, :spec, :unit, :price, :cost, :unit, :width, :height)
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
