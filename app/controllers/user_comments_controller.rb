class UserCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:id]
      @comment = Comment.find(params[:id])
      @comment.update(comment_params)
      @comment.update(:ispublic => params[:ispublic]) if params[:ispublic]
    else
      @comment = current_user.comments.new(comment_params)
      params[:ispublic] ? @comment.ispublic = true : @comment.ispublic = false
      @comment.obj = Obj.find(params[:obj_id])
      @comment.title = "Re: #{@comment.obj.name}" if @comment.title == "" || @comment.title.nil?
      @comment.save
    end
    redirect_to obj_path(params[:obj_id])   
  end

  def destroy
    Comment.find(params[:id]).destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :paragraph, :ispublic) 
  end

end
