class ObjsController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	before_action :set_obj, :only => [:show, :edit, :update, :destroy]

	def post_index
		redirect_to objs_path(:page=>params[:page], :id=>params[:id], :order=>params[:order], :category_ids=>obj_params[:category_ids])
	end

	def index
		# objs = Obj.where('for obj filter')
		# objs = objs.includes('all you need associate')

		@categories = Category.all
		@user_likeship_arr = current_user.user_likeships.pluck(:obj_id) if current_user
		
		if params[:keyword]
			@objs = Obj.where([ "name like ?", "%#{params[:keyword]}%" ])
		else
			@objs = Obj.all
		end

		if current_user && current_user.admin?
			@objs = @objs.includes(:user).includes(:comments => :user)
		else
			@objs = @objs.includes(:user).where(:ispublic => true)
			# byebug_無法加入沒有留言的文章
			@objs = @objs.includes(:public_comments => :user)
		end

		case params[:order]
		when "by_name"
			@objs = @objs.order('objs.name')
		when "by_newcomment"
			@objs = @objs.order('comments.id DESC').uniq
		when "by_hotest"
			# counter_cache(order_by_all_comments)
			@objs = @objs.order('objs.comments_count DESC')
		when "by_mostviewed"
			@objs = @objs.order('objs.views_count DESC')
		else
			@objs = @objs.order('objs.created_at')
		end

		if params[:category_ids]
			obj_catships_arr = ObjCategoryship.where(:category_id => params[:category_ids]).pluck(:obj_id).uniq
			@objs = @objs.where(:id => obj_catships_arr)
		end
		
		@objs = @objs.page(params[:page]).per(10)
		@objs = @objs.includes(:user_likeships).includes(:tags)

		if params[:id]
			@obj = Obj.find(params[:id])
		else
			@obj = Obj.new
		end
	end

	def new
		@obj = Obj.new
	end

	def show
		@obj.update(:views_count =>  @obj.views_count += 1)
		@obj_user_likeships = @obj.user_likeships.includes(:user)
		@obj_tags = @obj.tags
		@comments = @obj.comments.includes(:user) if @obj.comments
		@comment = @comments.where(:user => current_user).find_by_ispublic(false)
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
			@categories = Category.all
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
			@categories = Category.all
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
		@tpconstructions = tpconstruction["result"]["results"]
	end

	private

	def set_obj
		@obj = Obj.find(params[:id])
	end
	def obj_params
		if params[:obj]
			params.require(:obj).permit(
				:name, :serial, :datebought, :dateretire, :value, :snumber1, :snumber2, 
				:string, :description, :text, :custodian, :keyword, :ispublic, :image, :category_ids => []
			)
		end
	end
	def tpconstruction
    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=201d8ae8-dffc-4d17-ae1f-e58d8a95b162"
    raw_data = JSON.parse(RestClient.get(url))
    return raw_data
  end
end
