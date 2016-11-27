class TagsController < ApplicationController
  before_action :authenticate_user!
  def create
    unless tag_name.empty?
      @tags = Obj.find(params[:obj]).tags
      if @tags.find_by_name(tag_name)
        params[:tag][:name] = ""
      else
        @tags.create(:name => tag_name)
      end 
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def tag_name
    params[:tag][:name]
  end
end
