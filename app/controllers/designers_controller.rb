class DesignersController < ApplicationController

  before_action :set_designer, only: [:show, :edit, :update, :destroy]
  def index
    @designers = Designer.all
  end

  def edit

  end

  def new
    @designer = Designer.new
  end

  def create
    @designer = Designer.new(designer_params)
    respond_to do |format|
      if @designer.save
        #@good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        #@good.save
        format.html { redirect_to designers_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @designer.update(designer_params)
        #@good.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@good.name))
        #@good.save
        format.html { redirect_to designers_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @designer }
      else
        format.html { render :edit }
        format.json { render json: @designer.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @designer.destroy
    respond_to do |format|
      format.html { redirect_to designers_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_designer
    @designer = Designer.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def designer_params
    params.require(:designer).permit(:name, :tel)
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
