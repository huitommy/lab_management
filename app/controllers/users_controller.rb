class UsersController < PermissionsController
  before_action :authenticate_user!
  before_action :require_admin, only: [:index, :admin, :destroy]

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User was deleted"
    redirect_to users_path
  end

  def admin
    @user = User.find(params[:id])
    if @user.admin
      @user.update_attribute(:admin, false)
      @user.save
    else
      @user.update_attribute(:admin, true)
      @user.save
    end
    redirect_to users_path
  end
end
