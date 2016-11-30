class Api::UsersController < Api::BaseController
  # skip_befor_action_auth_for_devise(postman_testing)
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  #rescue_from (class)=> Ac_R_::R_N_F.. , with def somthing(e)=> e.message...do_something... => render json:....

  def index
  
    @users = User.all
    # response.headers['Content-Typea'] = 'abcdefg'
    # render json: { users: @users }
    # (想要customize的話請愛用prefix)
  end

  def show
    @user = User.find(params[:id])
    # render json: { user: @user }
  end

  def create
    byebug
    @user = User.new(params.require(:user).permit(:email, :password))
    if @user.save
      render json: { user: @user }
    else
      render json: { errors: @user.errors.full_messages }, status: 402
    end
  end

  def update
    @user = User.find(params[:id])
    render json: { user: @user }
  end
end
