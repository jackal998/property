class ObjsController < ApplicationController

before_action :find_id, :only => [:show, :edit, :update, :destroy]

@@obj=0
@@pgv=1

	def index
		@objs = Obj.page(params[:page]).per(10)
		@obj = @@obj
		@@obj = 0
		@@pgv = params[:page]
	end
	def new
		@obj = Obj.new
	end
	def show
	end
	def create
		byebug
		@obj = Obj.new(obj_params)
		
		if @obj.save
			flash[:notice] ="新增成功"
			redirect_to objs_path
		else
			@objs = Obj.page(params[:page]).per(10)
			@@pgv = params[:page]
			render :index
		end
	end
	def edit
		@@obj = @obj
		redirect_to (objs_path+"?page=#{@@pgv}")
	end
	def update

		if @obj.update(obj_params)
			flash[:notice] ="更新成功"
			redirect_to (objs_path+"?page=#{@@pgv}")
		else
			render :edit
		end
	end
	def destroy
		@obj.destroy
		flash[:alert] = "刪除成功"
		
	end

	private
	def find_id
		@obj = Obj.find(params[:id])
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
			:user,
			:ispublic)
		params.require(:datebought).permit(
			:year,
			:month,
			:day)
		params.require(:dateretire).permit(
			:year,
			:month,
			:day)
	end
end
