class CommentsController < ApplicationController

  def create
    @comment = comment.new(params[:comment])
    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @comment
    else
      flash[:error] = "Error creating comment. Please try again."
      render :new
    end
  end
  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "You need to own the comment to delete it."
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to [@topic, @post]
    end
  end
end
