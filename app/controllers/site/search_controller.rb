class Site::SearchController < SiteController

  def ads
    cookies[:search_term] = params[:q]
    @ads = Ad.search(params[:q], params[:page])
    @categories = Category.order_by_description
    cookies[:categories] = @categories.to_json
    puts ">>>>>>>>>>>>>>>> #{cookies[:categories]}"
  end
end
