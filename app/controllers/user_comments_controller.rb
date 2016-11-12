class UserCommentsController < ApplicationController

  def create
    current_user.objs.find(params[:obj]).comments.create(comment_params)
    redirect_to obj_path(params[:obj])
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :paragraph)
  end

end
