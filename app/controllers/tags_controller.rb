class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tag = Tag.find(params[:tag])
    tags_arr = Tag.where(:name => @tag.name).ids
    obj_arr = ObjTagship.where(:id => tags_arr).pluck(:obj_id).uniq
    @objs = Obj.where(:id => obj_arr).includes(:tags)
  end

  def create
    unless tag_name.empty?
      @tags = Obj.find(params[:obj]).tags
      if @tags.find_by_name(tag_name)
        params[:tag][:name] = ""
      else
        @tag = @tags.create(:name => tag_name)
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
