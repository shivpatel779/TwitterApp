class Api::V1::UsersController < ApplicationController
  before_action :get_user
  # user profile API
  # api/v1/users/1
  def show
    user_json = JSON.parse(@user.to_json)
    user_json[:following] = @user.following
    user_json[:followers] = @user.followers
    render json: user_json
  end


  def follow
    tobe_followed_user = User.find(params[:followed_id])
    if @user.following?(tobe_followed_user)
      render json: {message: "#{@user.email} is already following #{tobe_followed_user.email}"}
    else
      @user.follow(tobe_followed_user)
      render json: {message: "#{@user.email} has successfully followed #{tobe_followed_user.email}"}
    end
  end

  def unfollow
    begin
      tobe_unfollowed_user = Relationship.find_by(followed_id: params[:unfollowed_id]).followed
      @user.unfollow(tobe_unfollowed_user)
      render json: {message: "#{@user.email} has successfully unfollowed #{tobe_unfollowed_user.email}"}
    rescue Exception => e
      render json: {message: "User not found."}, status: 400
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end
