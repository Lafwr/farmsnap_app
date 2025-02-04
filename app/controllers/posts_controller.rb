class PostsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :like, :comment, :destroy]
  # before_action :set_post, only: [:show, :like, :comment, :destroy]
  # before_action :ensure_farmer, only: [:new, :create, :destroy]
  # before_action :authorize_post_deletion, only: [:destroy]

  def index
    @posts = Post.includes(:farmer, :likes, :comments).order(created_at: :desc).limit(16)
    # DESCENDING ORDER
    # @posts = Post.includes(:farmer, :likes, :comments).order(created_at: :desc).limit(16)

    # Research .includes -- Supposed efficient manner of loading
  end

  def show
  end

  def new
    @post = current_user.farmer.posts.build
  end

  def create_my_post
    @post = current_user.farmer.posts.build(post_params)
    if @post.save
      redirect_to my_posts_path, notice: "Post created successfully!"
    else
      render :new
    end
  end

  def my_posts
    @posts = current_user.farmer.posts.order(created_at: :desc)
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully!"
  end

  def like
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
    else
      @post.likes.create(user: current_user)
    end
    redirect_to post_path(@post)
  end

  def comment
    @comment = @post.comments.build(user: current_user, content: params[:comment][:content])
    if @comment.save
      redirect_to post_path(@post), notice: "Comment added!"
    else
      flash[:alert] = "Comment cannot be empty!"
      redirect_to post_path(@post)
    end
  end

  private

  def post_params
    # params.require(:post).permit(:caption, images: [])
    params.require(:post).permit(:caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def ensure_farmer
    unless current_user.farmer
      redirect_to root_path, alert: "Only farmers can create posts!"
    end
  end

  def authorize_post_deletion
    unless current_user.farmer == @post.farmer
      redirect_to posts_path, alert: "You can only delete your own posts!"
    end
  end

end
