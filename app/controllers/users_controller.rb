class UsersController < ApplicationController
before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @ucships = UserCollectionship.where(:user_id => params[:id])
    ucships_arr = @ucships.collect{ |ucship| ucship[:obj_id] }
    @objs = Obj.where(:id => ucships_arr)
    @user_comments = @user.comments.includes(:obj)
    @user_objs = @user.objs.includes(:comments)
  end

  def edit_collection
    @obj = Obj.find(params[:id])
    @user_collectionship = current_user.user_collectionships.find_by_obj_id(@obj)
    if @user_collectionship.nil?
      UserCollectionship.create(:user_id => current_user.id, :obj_id  => @obj.id)
    else
      @user_collectionship.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  def edit_like
    @obj = Obj.find(params[:id])
    @user_likeship = current_user.user_likeships.find_by_obj_id(@obj)
    if @user_likeship.nil?
      UserLikeship.create(:user_id => current_user.id, :obj_id  => @obj.id)
    else
      @user_likeship.destroy
    end
    respond_to do |format|
      format.js
    end
  end  


end
