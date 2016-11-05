class ObjsController < ApplicationController



	def index
		@objs = Obj.page(params[:page]).per(10)
		@@pgv = params[:page]
	end
	def new
		@obj = Obj.new
	end
	def show
		@obj = Obj.find(params[:id])
	end
	def edit
		@obj = Obj.find(params[:id])
	end
	def update
		@obj = Obj.find(params[:id])
		@obj.update(obj_params)
		redirect_to obj_path(@obj)
	end
	def destroy
		@obj = Obj.find(params[:id])
		
		@obj.destroy

		redirect_to (objs_path+"?page=#{@@pgv}")
	end

	private

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
