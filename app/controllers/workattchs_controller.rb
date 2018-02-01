class WorkattchsController < ApplicationController

  before_action :set_workattch, only: [:show, :edit, :update, :destroy]
  def index
    @workattchs = Workattch.all
  end

  def edit

  end

  def new
    @workatt = Workattch.new
  end

  def create
    @workattch = Workattch.new(workattch_params)
    respond_to do |format|
      if @workattch.save
        @workattch.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@workattch.name))
        @workattch.save
        format.html { redirect_to workattchs_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @workattch.update(workattch_params)
        @workattch.pinyin = safestring(HanziToPinyin.hanzi_to_pinyin(@workattch.name))
        @workattch.save
        format.html { redirect_to workattchs_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @workattch }
      else
        format.html { render :edit }
        format.json { render json: @workattch.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @workattch.destroy
    respond_to do |format|
      format.html { redirect_to workattchs_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_workattch
    @workattch = Workattch.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def work_params
    params.require(:workattch).permit(:name, :fa, :pinyin)
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
