class Backoffice::CategoriesController < BackofficeController
  before_action :set_category, only: %i(edit update)

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = CategoryService.create(params_category)

    unless @category.erros.any?
      redirect_to backoffice_categories_path, notice: "A categoria (#{@category.description}) cadastrada com sucesso!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(params_category)
      redirect_to backoffice_categories_path, notice: "A categoria (#{@category.description}) atualizada com sucesso!"
    else
      render :edit
    end
  end

  private

  def params_category
    params.require(:category).permit(:description)
  end

  def set_category
    @category = Category.friendly.find(params[:id])
  end
end
