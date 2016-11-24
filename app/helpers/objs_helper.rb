module ObjsHelper
  def collected?(obj_id)
    if @ucs
      return @ucs.include? obj_id
    else
      return @user_collectionship.nil?
    end
  end
  def liked?(obj_id)
    if @uls
      return @uls.include? obj_id
    else
      return @user_likeship.nil?
    end
  end  
end
