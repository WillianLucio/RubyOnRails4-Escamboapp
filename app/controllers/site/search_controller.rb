class Site::SearchController < SiteController

  def ads
    @ads = Ad.where(title: params[:q])
    @categories = Category.order_by_description
  end
end
