class UserCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    if params[:comment_id]
      @comment = Comment.find(params[:comment_id])
      @comment.update(comment_params)
      @comment.update(:ispublic => params[:ispublic]) if params[:ispublic]
    else
      @comment = current_user.comments.new(comment_params) 
      params[:ispublic] ? @comment.ispublic = true : @comment.ispublic = false
      @comment.obj = Obj.find(params[:obj])
      @comment.save
    end
    redirect_to obj_path(params[:obj])   
  end

  def destroy
    Comment.find(params[:id]).destroy
    # flash[:alert] = "comment deleted"
    respond_to do |format|
      format.js
    end
    # redirect_to obj_path(params[:obj])
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :paragraph, :ispublic) 
  end

end
