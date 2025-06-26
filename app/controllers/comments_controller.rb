class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [ :show, :edit, :update, :destroy ]
  
  def index
    @comments = @article.comments
  end

  def show; end

  def create
    @comment = @article.comments.create(comment_params)

    if @comment.save 
      redirect_to article_comments_path(@article), notice: "A comment has been has been posted."
    else
      flash[:notice] = "Failed to post a comment."
      render 'articles/show', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to article_comments_path(@article), notice: "The comment has been has been updated."
    else
      flash[:notice] = "Failed to update the comment."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_comments_path(@article), notice: "The comment has been has been deleted."
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
  
  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end
end