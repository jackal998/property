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
  def liked?(obj)
    if @user_likeship_arr
      return @user_likeship_arr.include? obj.id
    else
      return @user_likeship_arr
    end
  end
  def obj_link(obj)
    if obj.ispublic
      return obj_path(obj)
    else
      return editor_objs_path(:obj => obj)
    end
  end
  def index_name(obj)
    return simple_format("#{obj.name}\n( #{obj.description[0..25]}#{"..." if obj.description.length > 25} )", nil, :class => "text-left")
  end
end
