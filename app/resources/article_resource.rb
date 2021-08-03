class ArticleResource
  include Garage::Representer
  include Garage::Authorizable

  property :id
  property :title
  property :body

  delegate :id, :title, :body, to: :@article

  def initialize(article)
    @article = article
  end
end
