class ObjsController < ApplicationController
	def index
		@objs = Obj.page(params[:page]).per(10)
	end
	def new

	end
	def show
		@obj = Obj.find(params[:id])
	end
end
