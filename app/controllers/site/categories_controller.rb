class Site::CategoriesController < SiteController
  def show
    @categories = Category.order_by_description
    @category = Category.friendly.find(params[:id])
    @ads = Ad.by_category(@category).descending_order(9)
  end
end
