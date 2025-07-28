class AuthorsController < ApplicationController
  before_action :require_librarian, except: [ :index, :show ]
  before_action :set_author, only: [ :show, :edit, :update, :destroy ]

  def index
    @authors = Author.all
  end

  def show
    @books = @author.books
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to @author, notice: "Author was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @author.update(author_params)
      redirect_to @author, notice: "Author was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    if @author.books.any?
      redirect_to authors_url, alert: "Cannot delete author with existing books."
    else
      @author.destroy
      redirect_to authors_url, notice: "Author was successfully deleted."
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :biography, :birth_date, :nationality)
  end
end
