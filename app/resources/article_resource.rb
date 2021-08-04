class ArticleResource
  include Garage::Representer
  include Garage::Authorizable

  property :id
  property :title
  property :body
  property :user

  delegate :id, :title, :body, to: :@article

  def initialize(article)
    @article = article
  end

  def user
    @article.user.to_resource
  end
end
