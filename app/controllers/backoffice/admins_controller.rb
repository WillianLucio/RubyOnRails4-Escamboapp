class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: %i(edit update destroy)

  after_action :verify_authorized, only: %i(new destroy)
  after_action :verify_policy_scoped, only: :index

  def index
    @admins = policy_scope(Admin)
  end

  def new
    @admin = Admin.new
    authorize @admin
  end

  def create
    @admin = Admin.new(params_admin)
    update_roles
    if @admin.save
      redirect_to backoffice_admins_path, notice: "O Administrador (#{@admin.email}) foi cadastrado com sucesso!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    update_roles

    if @admin.update(params_admin)
      AdminMailer.update_email(@current_admin, @admin).deliver_now
      redirect_to backoffice_admins_path, notice: "O Administrador (#{@admin.email}) foi atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    authorize @admin
    admin_email = @admin.email

    if @admin.destroy
      redirect_to backoffice_admins_path, notice: "O Administrador (#{admin_email}) foi excluído com sucesso!"
    else
      render :new
    end
  end

  private

    def remove_all_roles
      Role.availables.each do |role|
        @admin.remove_role(role)
      end
    end

    def update_roles
      remove_all_roles
      roles = params[:admin].extract!(:role_ids)
      roles[:role_ids].each do |role|
        @admin.add_role(role)
      end
    end

    def set_admin
      @admin = Admin.find(params[:id])
    end

    def params_admin
      if password_blank?
        params[:admin].except!(:password, :password_confirmation)
      end

      if @admin.blank?
        params.require(:admin).permit(:name, :email, :role, :password, :password_confirmation)
      else
        params.require(:admin).permit(policy(@admin).permitted_attributes)
      end
    end

    def password_blank?
      params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
    end
end
