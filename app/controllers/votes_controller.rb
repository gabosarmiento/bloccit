class VotesController < ApplicationController
  before_filter :setup

  def up_vote
    update_vote(1)
    redirect_to :back
  end

  def down_vote
    update_vote(-1)
    redirect_to :back
  end


  private
  
  def setup
    # Just like other controllers, grab the parent objects
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    authorize! :create, Vote, message: "You need to be a user to do that."
    # Look for an existing vote by this person so we don't create multiple
    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote(new_value)
    if @vote && @vote.value == new_value # if it exists and is equal delete it to go back to undo state
      @vote.destroy
    elsif @vote && @vote.value != new_value # if it exists and is different update it (this is how reddit works)
      @vote.update_attribute(:value, new_value)
    elsif # create it
      @vote = current_user.votes.create(value: new_value, post: @post) 
    end
  end
  
end