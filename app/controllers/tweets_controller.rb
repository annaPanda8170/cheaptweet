class TweetsController < ApplicationController
  before_action :unless_signin, only: [:new, :create,]
  before_action :unless_mytweet, only: [:edit, :update, :destroy]
  def index
    @tweets = Tweet.all.includes(:user).order("created_at DESC")
  end
  def new
    @tweet = Tweet.new
  end
  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render action: :new
    end
  end
  def show
    @tweet = Tweet.find(params[:id])
  end
  def edit
    @tweet = Tweet.find(params[:id])
  end
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweet_path(params[:id])
    else
      render action: :edit
    end
  end
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    # redirect_to root_path
  end
  private
  def tweet_params
    params.require(:tweet).permit(:text).merge(user_id: current_user.id)
  end
  def unless_signin
    redirect_to tweets_path unless user_signed_in?
  end
  def unless_mytweet
    redirect_to tweets_path unless user_signed_in? && current_user.id == Tweet.find(params[:id]).user.id
  end
end