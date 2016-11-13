class ObjsController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	before_action :find_id, :only => [:index, :show, :edit, :update, :destroy]
	def index
		if params[:keyword]
			@objs = Obj.where( [ "name like ?", "%#{params[:keyword]}%" ] )
		else
			@objs = Obj.all
		end
		@objs = @objs.page(params[:page]).per(10)
	end
	def new
		@obj = Obj.new
	end
	def show
		@user = current_user
		@comments = @obj.comments.includes(:user) if @obj.comments
	end
	def create
		@obj = Obj.new(obj_params)
		edited_by_user

		if @obj.save
			flash[:notice] ="新增成功"
			redirect_to objs_path(:page=>params[:page])
		else
			@objs = Obj.page(params[:page]).per(10)
			render :index
		end
	end
	def edit
		redirect_to objs_path(:page=>params[:page],:id=>params[:id])
	end
	def update
		edited_by_user
		if @obj.update(obj_params)
			flash[:notice] ="更新成功"
			redirect_to objs_path(:page=>params[:page])
		else
			@objs = Obj.page(params[:page]).per(10)
			render :index
		end
	end
	def destroy
		@obj.destroy
		flash[:alert] = "刪除成功"
		redirect_to objs_path(:page=>params[:page])
	end

	private

	def find_id
		if params[:id]
			@obj = Obj.find(params[:id])
		else
			@obj=0
		end
	end

	def obj_params
		params.require(:obj).permit(
			:name, 
			:serial,
  		:datebought,
  		:dateretire,
			:value, 
			:snumber1, 
			:snumber2, 
			:string,
			:description, 
			:text,
			:custodian,
			:keyword,
			:ispublic)
	end

	def edited_by_user
		@obj.user = current_user
		@obj[:user] = current_user.email
	end
end
