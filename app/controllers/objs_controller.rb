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
		Obj.create(obj_params)
		redirect_to objs_path
	end
	def edit
	end
	def update
		@obj.update(obj_params)
		redirect_to obj_path(@obj)
	end
	def destroy
		@obj.destroy
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
