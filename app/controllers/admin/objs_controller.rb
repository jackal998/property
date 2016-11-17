class Admin::ObjsController < AdminApplicationController

  def index
    @objs = Obj.all.includes(:comments)
  end

  def del_category
    byebug
  end
end
