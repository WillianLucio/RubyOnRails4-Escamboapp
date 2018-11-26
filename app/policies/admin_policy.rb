class AdminPolicy < ApplicationPolicy
  def new?
    # user.full_access?
    user.has_role? Role::OPTIONS[0]
  end

  def edit?
    # user.full_access?
    user.has_role? Role::OPTIONS[0]
  end

  def destroy?
    # user.full_access?
    user.has_role? Role::OPTIONS[0]
  end

  def permitted_attributes
    # if user.full_access?
    if user.has_role? Role::OPTIONS[0]
      [:name, :email, :role, :password, :password_confirmation]
    else
      [:name, :email, :password, :password_confirmation]
    end
  end

  class Scope < Scope
    def resolve
      # if user.full_access?
      if user.has_role? Role::OPTIONS[0]
        scope.all
      else
        scope.with_restricted_access
      end
    end
  end
end
