class Admin::ObjsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate
  layout "admin"

  def index
    @objs = Obj.all.includes(:comments)
    @users = User.all

    @users = @users.page(params[:page]).per(10)
  end

  private

  def authenticate
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
    end  
  end
end
