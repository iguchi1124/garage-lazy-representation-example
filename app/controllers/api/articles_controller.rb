class Api::ArticlesController < Api::ApplicationController
  include Garage::RestfulActions

  def require_resources
    @resources = Article.includes(:user).page(page).per(per_page)
  end

  private

  def respond_with_resources_options
    { paginate: true }
  end

  def per_page
    params[:per_page] || 20
  end

  def page
    params[:page] || 1
  end
end
