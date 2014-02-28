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
  #Original update_vote method
  #def update_vote(new_value)
  #  if @vote # if it exists, update it
  #    @vote.update_attribute(:value, new_value)
  #  else # create it
  #    @vote = current_user.votes.create(value: new_value, post: @post)
  # end
  #end

  #if the user regrets his decision it shouldn't take into account his vote.
  # My analysis was made base on the fact that @vote.vale is either empty, 1 or -1.
  def update_vote(new_value)
    if @vote && @vote.value == new_value # if it exists, and is equal do nothing
      @vote.update_attribute(:value, 0)
    elsif @vote && @vote.value != new_value # if it exists, and is equal do nothing
      @vote.update_attribute(:value, new_value)
    elsif #create it just as it was in the original method
      @vote = current_user.votes.create(value: new_value, post: @post) 
    end
  end
  

end