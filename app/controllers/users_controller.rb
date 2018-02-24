class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 20).order("id desc")
    if params[:search]
      @users = User.where('name like ? or tel like ?',"%#{params[:search]}%","%#{params[:search]}%").paginate(:page => params[:page], :per_page => 20).order("id desc")
    end
  end

  def edit

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  def checklogin
    status = 'true'
    admin = User.find_by_login(params[:user][:login])
    if admin
      status = 'false'
    else
      status = 'true'
    end
    #render json: '{"status":'+status+'}'
    render json: status
  end

  def auth
@user = User.find(params[:id])

  end

  def saveauth
    status = '10000'
    user = User.find(params[:id])
    user.auth = params[:auth]
    user.save
    render json: status
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :idcard, :sex, :tel, :entrydate, :quitdate, :status, :password, :password_confirmation, :login)
  end
end
