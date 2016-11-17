class Admin::UsersController < AdminApplicationController

  def index
    @users = User.all
    @users = @users.page(params[:page]).per(10)
  end

end
