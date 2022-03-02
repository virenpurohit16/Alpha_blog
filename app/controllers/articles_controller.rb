class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :article_params, only: [:update, :create]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def update
      if @article.update(article_params)
        flash[:notice] = "Article was updated successfully."
        redirect_to @article
      else
        render 'edit'
      end
    end

    def destroy
      @article.destroy
      redirect_to articles_path
    end
    

    def show
    end

    def index
    @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

    def new
      @article = Article.new
      @article = current_user.articles.build
    end

    def create
      @article = current_user.articles.build(article_params)
      @article = Article.new(article_params)
      @article.user = @current_user
      if @article.save
      flash[:notice] = "Article was created successfully."
        redirect_to (@article)
      else
        render 'new'
      end
    end


    private

    def set_article
      @article = Article.find(params[:id])  
    end


    def article_params
      params.require(:article).permit(:title, :description, category_ids: [])
    end

    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your articles"
        redirect_to @article
      end
    end

  

end