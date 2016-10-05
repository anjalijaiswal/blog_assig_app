class PostsController < ApplicationController
  before_action :set_post, except: [:index, :most_popular, :latest, :new]
  before_filter :log_impression, only: :show

  def index
    @posts = Post.all
  end

  def most_popular
    @posts = Post.order(count: :desc)
    render template: 'posts/index'
  end

  def search
  end

  def latest
    @posts = Post.order(created_at: :desc)
    render template: 'posts/index'
  end

  def show
    @post.update_count
  end

  def log_impression
    @post.impressions.create(ip_address: request.remote_ip)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Successfully created post!'
      redirect_to post_path(@post)
    else
      flash[:alert] = 'Error creating new post!'
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Successfully updated post!'
      redirect_to post_path(@post)
    else
      flash[:alert] = 'Error updating post!'
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Successfully deleted post!'
      redirect_to posts_path
    else
      flash[:alert] = 'Error updating post!'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
