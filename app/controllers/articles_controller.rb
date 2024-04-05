class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def index
    @articles = Article.all
  end
  def show
    
  end
  def new
    @articles = Article.new
  end
  def edit
  end
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "article is created successfully"
      redirect_to @article
    else
      render 'new'
    end
  end
  def update
    if @article.update(article_params)
      flash[:notice] = "article is updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end
  def destroy
    if @article.destroy
      flash[:notice] = "article is deleted successfully"
      redirect_to articles_path
    else
      redirect_to @article
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :description, :image)
  end

end
