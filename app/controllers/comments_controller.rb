class CommentsController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  def show
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)

    if @comment.save 
      redirect_to article_comments_path(@article), notice: "A comment has been has been posted."
    else
      flash[:notice] = "Failed to post a comment."
      render 'articles/show', status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to article_comments_path(@article), notice: "The comment has been has been updated."
    else
      flash[:notice] = "Failed to update the comment."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_comments_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end