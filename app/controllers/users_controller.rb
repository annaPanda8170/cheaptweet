class UsersController < ApplicationController
  def show
    @tweets = Tweet.where(user_id: params[:id]).order("created_at DESC").page(params[:page]).per(5)
    @nickname = User.find(params[:id]).nickname
  end
end