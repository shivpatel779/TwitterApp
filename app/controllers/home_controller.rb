class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    tweets = current_user.following.map(&:tweets).reject(&:empty?)
    @following_tweets = Tweet.includes(:user).where(id: tweets).order("created_at DESC")
  end

  def follow_users
    @other_users = User.where.not(id: current_user.id)
  end
end
