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
		@objs = Obj.where(schedule_public: '1900-01-01 00:00:00')
		
		@objs = @objs.where([ "name like ?", "%#{params[:keyword]}%" ]) if params[:keyword]

		if current_user && current_user.admin?

			@objs = @objs.includes(:user).includes(:comments => :user)
		else
			@objs_read_only = @objs.where("access_authority = ?", 3)
			@objs_open_to_every_one = @objs.where("access_authority = ?", 4)
			if current_user
				# 文章可以設定權限：1. 只有自己可以看 2. 限好友才能看跟留言 3. 別人只能看不能留言 4. 別人可以看也能留言
				@objs_only_me = @objs.where("access_authority = ? and user_id = ?", 1, current_user.id )
				@objs_friends_only = @objs.where(:user_id => friends_arr).where('access_authority = ?',2)
				@objs = @objs_only_me.or(@objs_friends_only).or(@objs_read_only).or(@objs_open_to_every_one)
			else
				@objs = @objs_read_only.or(@objs_open_to_every_one)
			end

			@objs = @objs.includes(:user).where(:ispublic => true)
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
		@obj.schedule_public = Time.now
		if @obj.save
			set_schedule
			@obj = Obj.new
			@success = true
		end
		render :form_template
	end

	def edit
		redirect_to objs_path(:page=>params[:page],:id=>params[:id])
	end

	def update
		if params[:del]
			@obj.image = nil
		end
		if @obj.update(obj_params)
			set_schedule
			flash[:notice] ="更新成功"
			redirect_to objs_path(:page=>params[:page])
		else
			render :form_template
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
				:string, :description, :text, :custodian, :keyword, :ispublic, :access_authority, :image, :category_ids => []
			)
		end
	end
	def tpconstruction
    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=201d8ae8-dffc-4d17-ae1f-e58d8a95b162"
    raw_data = JSON.parse(RestClient.get(url))
    return raw_data
  end
  def date_array(params_date_hash)
  	schedule_day = %w(1 2 3).map { |e| params_date_hash["schedule_public(#{e}i)"].to_i }.join('-')
  	schedule_time = %w(4 5).map { |e| params_date_hash["schedule_public(#{e}i)"].to_i }.join(':')
  	set_datetime = schedule_day + " " + schedule_time + ":00"
	end
	def set_schedule
		if params[:schedule_now]['{:checked=>false}'] == "1"
			set_datetime = date_array(params.to_unsafe_h[:obj])
			if Time.now + 3600 * 8 > set_datetime
				@obj.update(schedule_public: '1900-01-01 00:00:00')
			else
				@obj.update(schedule_public: set_datetime)
			end
		end
	end
	def friends_arr
		my_friends_arr = current_user.userships.pluck(:friend_id)
    added_me_arr = Usership.where(:friend_id => current_user.id).pluck(:user_id)
    friends_arr = added_me_arr & my_friends_arr
	end
end
