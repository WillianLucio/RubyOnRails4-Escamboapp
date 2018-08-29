class BackofficeController < ApplicationController
  layout 'backoffice'
  before_action :authenticate_admin!

  def pundit_user
    current_admin # Current user to Pundit.
  end
end
