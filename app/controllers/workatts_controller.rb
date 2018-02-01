class WorkattsController < ApplicationController

  before_action :set_workatt, only: [:show, :edit, :update, :destroy]
  def index
    @workatts = Workatt.all
  end

  def edit

  end

  def new
    @workatt = Workatt.new
  end

  def create
    @workatt = Workatt.new(workatt_params)
    respond_to do |format|
      if @workatt.save
        @workatt.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@workatt.name))
        @workatt.save
        format.html { redirect_to workattchs_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @workatt.update(workatt_params)
        @workatt.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@workatt.name))
        @workatt.save
        format.html { redirect_to workattchs_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @workatt }
      else
        format.html { render :edit }
        format.json { render json: @workatt.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @workatt.destroy
    respond_to do |format|
      format.html { redirect_to workatts_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_workatt
    @workatt = Workatt.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def workatt_params
    params.require(:workatt).permit(:name, :fa, :pinyin)
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
