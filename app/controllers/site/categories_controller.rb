class Site::CategoriesController < SiteController
  def show
    @categories = Category.order_by_description
    @ads = Ad.where_category(params[:id]).descending_order(9)
  end
end
