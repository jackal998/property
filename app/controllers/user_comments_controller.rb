class UserCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params) 
    @comment.obj = Obj.find(params[:obj])
    @comment.save

    redirect_to obj_path(params[:obj])
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:alert] = "comment deleted"
    redirect_to obj_path(params[:obj])
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :paragraph) 
  end

end
