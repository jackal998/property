class UsersController < ApplicationController
before_action :authenticate_user!

  def show
    @user = User.find(params[:id])

    user_collection_arr = UserCollectionship.where(:user_id => params[:id]).pluck(:obj_id)
    @user_collection_objs = Obj.includes(:user).where(:id => user_collection_arr)

    user_like_arr = UserLikeship.where(:user_id => params[:id]).pluck(:obj_id)
    @user_like_objs = Obj.where(:id => user_like_arr)

    @user_comments = @user.comments.includes(:obj)
    @user_objs = @user.objs.includes(:comments)
  end

  def edit_collection
    @obj = Obj.find(params[:id])
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
    @obj = Obj.find(params[:id])
    @user_likeship = current_user.user_likeships.find_by_obj_id(@obj)
    if @user_likeship
      @user_likeship.destroy
    else
      UserLikeship.create(:user_id => current_user.id, :obj_id  => @obj.id)
    end
    respond_to do |format|
      format.js
    end
  end
  def edit_subscribe
    @obj = Obj.find(params[:id])
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
end
