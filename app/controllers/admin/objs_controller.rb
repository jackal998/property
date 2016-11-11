class Admin::ObjsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate
  layout "admin"

  def index
    @objs = Obj.all
  end

  private

  def authenticate
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
    end  
  end
end
