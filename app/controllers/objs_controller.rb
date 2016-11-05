class ObjsController < ApplicationController

before_action :find_id, :only => [:show, :edit, :update, :destroy]

	def index
		@objs = Obj.page(params[:page]).per(10)
		@@pgv = params[:page]
	end
	def new
		@obj = Obj.new
	end
	def show
	end
	def create
		@obj = Obj.new(obj_params)
		if @obj.save
			flash[:notice] ="新增成功"
			redirect_to objs_path
		else
			render :new
		end
	end
	def edit
	end
	def update
		if @obj.update(obj_params)
			flash[:notice] ="更新成功"
			redirect_to obj_path(@obj)
		else
			render :edit
		end
	end
	def destroy
		@obj.destroy
		flash[:alert] = "刪除成功"
		redirect_to (objs_path+"?page=#{@@pgv}")
	end

	private
	def find_id
		@obj = Obj.find(params[:id])
	end

	def obj_params
		params.require(:obj).permit(
			:name, 
			:serial, 
			:value, 
			:snumber1, 
			:snumber2, 
			:string,
			:description, 
			:text,
			:user)
	end
end
