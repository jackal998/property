class ObjsController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	before_action :find_id, :only => [:index, :show, :edit, :update, :destroy]

	def post_index
		redirect_to objs_path(:page=>params[:page], :id=>params[:id], :order=>params[:order], :category_ids=>obj_params[:category_ids])
	end	

	def index
		if params[:keyword]
			@objs = Obj.where( [ "name like ?", "%#{params[:keyword]}%" ] ).includes(:comments)
		else
			@objs = Obj.all.includes(:comments)
		end

		case params[:order]
		when "by_name"
			@objs = @objs.order('name')
		when "by_newcomment"
			@objs = @objs.order('comments.created_at DESC').distinct 
		when "by_hotest"
			@objs = @objs.order('comments_count DESC')
		when "by_mostviewed"
			@objs = @objs.order('views_count DESC')
		else
			@objs = @objs.order('created_at')
		end

		if params[:category_ids]
			obj_catships_arr = ObjCategoryship.where(:category_id =>params[:category_ids]).collect{ |ocs| ocs[:obj_id] }.uniq
			@objs = @objs.where(:id => obj_catships_arr)

			@objs = @objs.page(1).per(10)
		else
			# page之後排序有誤
			@objs = @objs.page(params[:page]).per(10)
		end
		@objs = @objs.includes(:user)
	end

	def new
		@obj = Obj.new
	end

	def show
		@user = current_user
		@obj.update(:views_count =>  @obj.views_count += 1)
		@comments = @obj.comments.includes(:user) if @obj.comments
	end

	def create
		@obj = Obj.new(obj_params)
		@obj.user = current_user

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

	def about
		@objs = Obj.all
		@comments = Comment.all
		@users = User.all
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
			:ispublic,
			:category_ids => [])
	end
end
