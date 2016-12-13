class Admin::CategoriesController < AdminApplicationController
  
  def edit
    redirect_to admin_users_path(:category_id => params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(:name => params[:category][:name])
    redirect_to admin_users_path
  end

  def create
    if params[:commit]
      @categories = Category.where(:id => params[:category_ids])
      @categories.each do |c|
        c.destroy
      end
    else
      Category.create(:name => params[:category][:name])
    end
    redirect_to admin_users_path
  end
end
