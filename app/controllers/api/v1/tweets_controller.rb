class Api::V1::TweetsController < ApplicationController
  before_action :get_user

  # /api/v1/users/1/tweets/
  def index
    render json: @user.tweets
  end

  # /api/v1/users/1/tweets/followings?sort_order=desc
  def followings
    tweets = @user.following.map(&:tweets).reject(&:empty?)
    render json: Tweet.where(id: tweets).order("created_at #{params[:sort_order] || 'ASC'}")
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end

end
