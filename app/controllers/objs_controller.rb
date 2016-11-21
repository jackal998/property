class ObjsController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	before_action :find_id, :only => [:index, :show, :edit, :update, :destroy]

	def post_index
		redirect_to objs_path(:page=>params[:page], :id=>params[:id], :order=>params[:order], :category_ids=>obj_params[:category_ids])
	end

	def index
		# objs = Obj.where('for obj filter')
		# objs = objs.includes('all you need associate')
		@categories = Category.all
		@objs = Obj.includes(:user).includes(:comments => :user).where(:ispublic => true)
		
		if params[:keyword]
			@objs = @objs.where( [ "name like ?", "%#{params[:keyword]}%" ] )
		end

		if current_user
			if current_user.admin?
				@objs = Obj.includes(:comments => :user)
			end
			@ucs = UserCollectionship.where(:user_id => current_user.id).pluck(:obj_id)
		end

		case params[:order]
		when "by_name"
			@objs = @objs.order('name')
		when "by_newcomment"
			@objs = @objs.order('comments.id DESC').uniq
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
			@objs = @objs.page(params[:page]).per(10)
		end
	end

	def new
		@obj = Obj.new
	end

	def show
		@user = current_user
		@obj.update(:views_count =>  @obj.views_count += 1)
		@comments = @obj.comments.includes(:user) if @obj.comments
		@comment = @comments.where(:user => @user).find_by_ispublic(false)
		@comment = Comment.new unless @comment
	end

	def editor
		@obj = Obj.find(params[:obj])
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
		if params[:del]
			@obj.image = nil
		end
		
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
		if params[:obj]
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
				:image,
				:category_ids => [])
		end
	end
end
