class UsersController < ApplicationController
  def show
    @user = User.find(current_user)
    @user_comments = @user.comments.includes(:obj)
    @user_objs = @user.objs.includes(:comments)
  end
end
