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

  def edit
    @ucship = UserCollectionship.where(:user_id => current_user.id)
    @uc = @ucship.find_by_obj_id(params[:id])
    if @uc.nil?
      UserCollectionship.create(:user_id => current_user.id, :obj_id  => params[:id])
    else
      @uc.destroy
    end
    redirect_to objs_path(:page => params[:page], :order => params[:order])
  end
end
