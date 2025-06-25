class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    @articles = Article.all
  end

  def show
    @comment = @article.comments.new
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: "The article \"#{@article.title}\" has been created."
    else
      flash[:notice] = "Failed to create an article."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "The article \"#{@article.title}\" has been has been updated."
    else
      flash[:notice] = "Failed to update the article."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "The article \"#{@article.title}\"Z has been deleted."

    redirect_to root_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
