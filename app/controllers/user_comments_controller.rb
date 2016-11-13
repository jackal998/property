class UserCommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.obj = Obj.find(params[:obj])
    @comment.save

    redirect_to obj_path(params[:obj])
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :paragraph) 
  end

end
