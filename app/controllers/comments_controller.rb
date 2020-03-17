class CommentsController < ApplicationController
  def create
    redirect_to tweets_path unless user_signed_in?
    @comment = Comment.new(params_comment)
    @comment.save
    redirect_to tweet_path(params[:tweet_id])
  end
  private
  def params_comment
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end