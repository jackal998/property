class Api::UsersController < ApplicationController
  # skip_befor_action_auth_for_devise(postman_testing)
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  def index
    @users = User.all
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = '' #CRUD
    response.headers['Access-Control-Request-Methods'] = '' #CRUD（基本沒差，可能是clien端名稱問題）
    response.headers['Content-Typea'] = 'abcdefg'
    render json: { users: @users }
    # (想要customize的話請愛用prefix)
  end

  def show
    @user = User.find(params[:id])
    render json: { user: @user }
  end

  def create
    byebug
    @user = User.new(params.require(:user).permit(:email, :password))
    if @user.save
      render json: { user: @user }
    else
      render json: { errors: @user.errors.full_messages }
    end
  end
end
