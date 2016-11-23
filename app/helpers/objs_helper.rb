module ObjsHelper
  def liked?(obj_id)
    if @ucs
      return @ucs.include? obj_id
    else
      return @user_collectionship.nil?
    end
  end 
end
