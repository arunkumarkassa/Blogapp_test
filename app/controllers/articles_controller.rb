class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = current_user.articles.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def search
    if params[:search]
      @searched_articles = Article.where("title LIKE ?", "%#{params[:search]}%")
    else
      @searched_articles = Article.all
    end
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article is created successfully"
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article is updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Article is deleted successfully"
    else
      flash[:alert] = "Failed to delete the article."
    end
    redirect_to articles_path
  end

  def bulkdata
  end

  def export_csv
    respond_to do |format|
      format.csv { send_data Article.generate_csv, filename: "(#{Time.now})ArticlesCsvData.csv", type: 'text/csv' }
    end
  end

  def import
    if params[:file].present?
      if params[:file].content_type == "text/csv"
        @duplicate_val = 0
        file = params[:file].read
        csv = CSV.parse(file, headers: true)
        expected_headers = ['title', 'description']
        csv_headers = csv.headers.map(&:strip)
        if expected_headers != csv_headers
          flash[:alert] = "The file does not have the expected header values."
          redirect_to root_path
          return
        end
        csv.each do |row|
          @current_article = Article.find_by(title: row['title'])
          if @current_article.nil?
            Article.create(title: row['title'], description: row['description'], user: current_user)
          else
            @duplicate_val += 1
          end
        end
        if @duplicate_val > 0
          flash[:alert] = "Found #{@duplicate_val} duplicate records but not saved in the database."
        end
        redirect_to root_path
      else
        flash[:alert] = "Only '.csv' files are valid for import."
        redirect_to root_path
      end
    else
      flash[:alert] = "Please choose a file to import."
      redirect_to root_path
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
