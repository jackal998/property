class Admin::UsersController < AdminApplicationController
before_action :find_user, :only => [:edit, :update, :destroy]

  def index
    @users = User.all
    @users = @users.page(params[:page]).per(10)
    if params[:category_id]
      @category = Category.find(params[:category_id])
    else
      @category = Category.new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user.update(user_params)
    flash[:notice] = "successful updated " + @user.email + " informations."
    redirect_to admin_users_path
  end

  def destroy
    flash[:warning] = "successful deleted " + @user.email
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :nickname, :firstname, :lastname, :role)
  end
end
