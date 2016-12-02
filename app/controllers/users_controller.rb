class UsersController < ApplicationController

  helper_method :friend?

  def show
    @user = User.find(params[:id])

    user_collection_arr = UserCollectionship.where(:user_id => params[:id]).pluck(:obj_id)
    @user_collection_objs = Obj.includes(:user).where(:id => user_collection_arr)

    user_like_arr = UserLikeship.where(:user_id => params[:id]).pluck(:obj_id)
    @user_like_objs = Obj.where(:id => user_like_arr)

    @user_comments = @user.comments.includes(:obj)
    @user_objs = @user.objs.includes(:public_comments)
  end
  def edit_collection
    @obj = Obj.find(params[:obj_id])
    @user_collectionship = current_user.user_collectionships.find_by_obj_id(@obj)
    if @user_collectionship
      @user_collectionship.destroy
    else
      UserCollectionship.create(:user_id => current_user.id, :obj_id  => @obj.id)
    end
    respond_to do |format|
      format.js
    end
  end
  def edit_like
    @obj = Obj.find(params[:obj_id])
    @user_likeship = current_user.user_likeships.find_by_obj_id(@obj)
    if @user_likeship
      @user_likeship.destroy
      @user_likeship_arr = nil
    else
      UserLikeship.create(:user_id => current_user.id, :obj_id  => @obj.id)
      @user_likeship_arr = [params[:obj_id].to_i]
    end
    respond_to do |format|
      format.js
    end
  end
  def edit_subscribe
    @obj = Obj.find(params[:obj_id])
    @user_subscribeship = current_user.user_subscribeships.find_by_obj_id(@obj)
    if @user_subscribeship
      @user_subscribeship.destroy
    else
      UserSubscribeship.create(:user_id => current_user.id, :obj_id  => @obj.id)
    end
    respond_to do |format|
      format.js
    end
  end
  def edit_friendship
    @friend = User.find(params[:friend_id])
    if friend?(@friend)
      Usership.find_by_user_id_and_friend_id(current_user.id, @friend.id).destroy
    else
      Usership.create(:user=>current_user,:friend_id=>@friend.id)
    end
    respond_to do |format|
      format.js
      format.html { redirect_to show_friends_users_path }
    end
  end
  def show_friends
    @user = current_user
    my_friends_arr = @user.userships.pluck(:friend_id)
    added_me_arr = Usership.where(:friend_id => @user.id).pluck(:user_id)
    requests_arr = added_me_arr - (added_me_arr&my_friends_arr) if (added_me_arr&my_friends_arr) != added_me_arr
    @my_friends = User.where(:id => my_friends_arr)
    @friend_requests = User.where(:id => requests_arr)
  end
  def friend?(friend)
    current_user.userships.find_by_friend_id(friend).present?
  end
end
