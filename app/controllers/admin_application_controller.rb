class AdminApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate
  layout "admin"

  private

  def authenticate
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
    end  
  end
end
