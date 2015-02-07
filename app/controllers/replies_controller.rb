class RepliesController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new
    @reply = Reply.new
  end

  def create
    @reply = Reply.create(reply_params)
  end

  def voteup
    @post = Post.find(params[:id])
    if current_user
      @reply = Reply.find(params[:name])
      Vote.create(vote: true, votable: @reply, voter_id: current_user.id, vote_weight: 1)
      redirect_to post_path(@post)
    else
      flash[:notice] ="Please sign in to vote!!!!!!"
      redirect_to post_path(@post)
    end
  end

  def votedown
    @post = Post.find(params[:id])
    if current_user
      @reply = Reply.find(params[:name])
      Vote.create(vote: false, votable: @reply, voter_id: current_user.id, vote_weight: 1)
      redirect_to post_path(@post)
    else
      flash[:notice] ="Please sign in to vote!!!!!!"
      redirect_to post_path(@post)
    end
  end

 private

  def reply_params
    params.require(:reply).permit(:text, :replier_id)
  end
end
