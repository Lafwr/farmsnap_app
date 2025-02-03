class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :like, :comment, :destroy]
  before_action :set_post, only: [:show, :like, :comment, :destroy]
  before_action :ensure_farmer, only: [:new, :create, :destroy]
  before_action :authorize_post_deletion, only: [:destroy]

  def index
    # DESCENDING ORDER
    @posts = Post.includes(:farmer, :likes, :comments).order(created_at: :desc)
    # ADD LIMIT?
    # Research .includes -- Supposed efficient manner of loading
  end

  def show

  end

  def new
    @post = current_user.farmer.posts.build
  end
end
