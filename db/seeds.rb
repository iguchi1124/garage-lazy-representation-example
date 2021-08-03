users = 10.times.map do |i|
  user = User.find_or_initialize_by(email: "user_#{i}@example.com")
  user.username = "user_#{i}"
  user.password = 'password'
  user.save!
  user
end

articles = users.flat_map do |user|
  3.times.map do |i|
    article = user.articles.find_or_initialize_by(slug: "lorem_ipsum_#{user.id}_#{i}")
    article.title = "Lorem Ipsum"
    article.body = <<~BODY
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
      Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
      Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
      Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    BODY
    article.save!
    article
  end
end

articles.to_a.product(users).map do |article, user|
  comment = article.comments.find_or_initialize_by(user: user)
  comment.body = "comment from #{user.username}"
  comment.save!
end
