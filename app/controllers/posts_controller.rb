class PostsController < ApplicationController

  def index

  end

  def show

  end

  def new
    @post = current_user.farmer.posts.build
  end
end
