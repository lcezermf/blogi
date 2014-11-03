class PostsController < ApplicationController
  before_action :load_resources, only: [:index, :new]

  def index
    @search = BlogiSearch.new(params[:search_term])
    @posts  = @search.search.only(:id).load(post: { scope: Post })
    # @posts = Post.order('id DESC')
    # respond_with @posts
  end

  def show
    @post = Post.joins(:category, :author).find params[:id]
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params

    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def load_resources
    @authors = Author.all
    @categories = Category.all
  end

  def post_params
    params.require(:post).permit(:title, :description, :author_id, :category_id)
  end

end
