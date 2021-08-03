class Api::ArticlesController < Api::ApplicationController
  include Garage::RestfulActions

  def require_resources
    @resources = Article.all
  end

  private

  def respond_with_resources_options
    { paginate: true }
  end
end
