class CommentsController < ApplicationController
  # def create
  #   user = User.find(params[:user_id])
  #   post = Post.find(params[:post_id])
  #   @comment = post.comments.new(author_id: current_user, **comment_param)
  #   if @comment.save
  #     redirect_to user_post_path(current_user, post)
  #   else
  #     redirect_to user_post_path(current_user), alert: 'Failed to add comment!'
  #   end
  # end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_param)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to(request.referrer || root_path)
    else
      render :new
    end
  end

  private

  def comment_param
    params.require(:comment).permit(:text)
  end
end
