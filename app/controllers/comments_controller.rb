class CommentsController < ApplicationController
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
