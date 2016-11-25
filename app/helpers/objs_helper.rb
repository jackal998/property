module ObjsHelper
  def collected?(obj_id)
    if @ucs
      return @ucs.include? obj_id
    else
      return @user_collectionship.nil?
    end
  end
  def subscribed?(obj_id)
    if @uss
      return @uss.include? obj_id
    else
      return @user_subscribeship.nil?
    end
  end 
  def liked?(obj_id)
    if @uls
      return @uls.include? obj_id
    else
      return @user_likeship.nil?
    end
  end
  def user_show_link(obj)
    if obj.ispublic
      return obj_path(obj)
    else
      return editor_objs_path(:obj => obj)
    end
  end
end
