class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, :author)
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
    @like = Like.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      puts @post.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
