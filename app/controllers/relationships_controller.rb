class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def follow
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to follow_users_path }
      format.js
    end
  end

  def unfollow
    @user = Relationship.find_by(followed_id: params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to follow_users_path }
      format.js
    end
  end
end
