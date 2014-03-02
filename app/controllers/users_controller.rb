class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    @comments = @user.comments
  end
end
