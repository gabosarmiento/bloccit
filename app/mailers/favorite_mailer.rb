class FavoriteMailer < ActionMailer::Base
  default from: "gabrielsarmiento@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    # New Headers
    headers["Message-ID"] = "<comments/#{@comment.id}@g-bloccit>"
    headers["In-Reply-To"] = "<post/#{@post.id}@g-bloccit>"
    headers["References"] = "<post/#{@post.id}@g-bloccit>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
