class BooksController < ApplicationController
  before_action :require_librarian, except: [ :index, :show, :dashboard, :search ]
  before_action :set_book, only: [ :show, :edit, :update, :destroy, :borrow, :return_book ]

  def index
    @books = Book.includes(:author).all
  end

  def show
    @borrowings = @book.borrowings.includes(:member)
  end

  def new
    @book = Book.new
    @authors = Author.all
  end

  def create
    @book = Book.new(book_params)
    @book.available = true

    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      @authors = Author.all
      render :new
    end
  end

  def edit
    @authors = Author.all
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      @authors = Author.all
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: "Book was successfully deleted."
  end

  def dashboard
    @total_books = Book.count
    @available_books = Book.where(available: true).count
    @borrowed_books = Book.where(available: false).count
    @overdue_borrowings = Borrowing.where(status: "overdue").count
  end

  def search
    if params[:query].present?
      @books = Book.joins(:author).where(
        "books.title ILIKE ? OR authors.name ILIKE ? OR books.isbn ILIKE ?",
        "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"
      ).includes(:author)
    else
      @books = Book.includes(:author).all
    end
  end
    def borrow
    @members = Member.where(active: true)

    if request.post?
      member = Member.find(params[:member_id])
      borrowing = @book.borrowings.build(
        member: member,
        borrowed_date: Date.current,
        due_date: Date.current + 14.days,
        status: "borrowed"
      )

      if borrowing.save
        @book.update(available: false)
        redirect_to @book, notice: "Book was successfully borrowed."
      else
        redirect_to @book, alert: "Error borrowing book."
      end
    end
  end

  def return_book
    active_borrowing = @book.borrowings.find_by(status: "borrowed")

    if active_borrowing
      active_borrowing.update(status: "returned", returned_date: Date.current)
      @book.update(available: true)
      redirect_to @book, notice: "Book was successfully returned."
    else
      redirect_to @book, alert: "No active borrowing found for this book."
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author_id, :isbn, :publication_year, :genre, :description)
  end
end
