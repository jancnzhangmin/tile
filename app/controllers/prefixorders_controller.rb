class PrefixordersController < ApplicationController

  before_action :set_prefixorder, only: [:show, :edit, :update, :destroy]
  def index
    @prefixorder = Prefixorder.first
    if @prefixorder
      redirect_to edit_prefixorder_path(@prefixorder)
    else
      @prefixorder = Prefixorder.create(raw:'YCL',preorder:'DD',work:'JGD')
      redirect_to edit_prefixorder_path(@prefixorder)
    end
  end

  def edit

  end

  def new
    @prefixorder = Prefixorder.new
  end

  def create
    @prefixorder = Prefixorder.new(prefixorder_params)
    respond_to do |format|
      if @prefixorder.save
        #@good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        #@good.save
        format.html { redirect_to prefixorders_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @prefixorder.update(prefixorder_params)
        #@good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        #@good.save
        flash[:success] = "信息成功保存"
        format.html { redirect_to edit_prefixorder_path(@prefixorder) }
        format.json { render :show, status: :ok, location: @prefixorder }
      else
        format.html { render :edit }
        format.json { render json: @prefixorder.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @prefixorder.destroy
    respond_to do |format|
      format.html { redirect_to prefixorders_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_prefixorder
    @prefixorder = Prefixorder.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def prefixorder_params
    params.require(:prefixorder).permit(:raw, :preorder, :work)
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
