class LikesController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!

  def create
    like = @post.likes.new(user: current_user)

    if like.save
      redirect_to all_posts_path, notice: "You liked this post."
    else
      redirect_to all_posts_path, alert: "Unable to like this post."
    end
  end

  def destroy
    like = @post.likes.find_by(id: params[:id], user: current_user)

    if like
      like.destroy
      redirect_to all_posts_path, notice: "Like removed."
    else
      redirect_to all_posts_path, alert: "Like not found."
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
