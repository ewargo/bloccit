class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])

  def create
    @comment = current_user.comments.build(params[:comments])
    if @comment.save
      flash[:notice] = "Comment was saved successfully."
      redirect_to @comment
    else
      flash[:error] = "Error creating comment. Please try again."
      render :new
    end
  end
  def destroy
    @comment = @comment.posts.find(params[:comments])

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
