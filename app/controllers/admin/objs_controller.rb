class Admin::ObjsController < AdminApplicationController

  def index
    @objs = Obj.all.includes(:comments)
  end

end
