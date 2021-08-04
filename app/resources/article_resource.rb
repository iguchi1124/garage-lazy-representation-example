class ArticleResource
  include Garage::Representer
  include Garage::Authorizable

  property :id
  property :title
  property :body
  property :user

  attr_reader :id, :title, :body

  def initialize(article)
    @id = article.id
    @title = article.title
    @body = article.body
    @user_promise = Current.user_loader.load(article.user_id).then { |user| user.to_resource }
  end

  def user
    @user ||= @user_promise.sync
  end
end
