class Admin::CategoriesController < AdminApplicationController
  
  def edit
    redirect_to admin_users_path(:id => params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(:name => params[:category][:name])
    redirect_to admin_users_path
  end

  def create
    if params[:commit].nil?
      Category.create(:name => params[:category][:name])
    else
      @categories = Category.where(:id => params[:category_ids])
      @categories.each do |c|
        c.destroy
      end
    end
    redirect_to admin_users_path
  end
end
