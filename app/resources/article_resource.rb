class ArticleResource
  include Garage::Representer
  include Garage::Authorizable
  include GarageLazyRepresenter

  property :id
  property :title
  property :body
  lazy_property :user
  lazy_collection :comments

  attr_reader :id, :title, :body, :user, :comments

  def initialize(article)
    @id = article.id
    @title = article.title
    @body = article.body
    @user = Current.user_loader.load(article.user_id).then { |user| user.to_resource }
    @comments = Current.comment_loader.load_many(article.comment_ids).then { |comments| comments.map(&:to_resource) }
  end
end
