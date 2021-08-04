class CommentResource
  include Garage::Representer
  include Garage::Authorizable
  include GarageLazyRepresenter

  property :id
  property :body
  lazy_property :user

  attr_reader :id, :body, :user

  def initialize(comment)
    @id = comment.id
    @body = comment.body
    @user = Current.user_loader.load(comment.user_id).then { |user| user.to_resource }
  end
end
