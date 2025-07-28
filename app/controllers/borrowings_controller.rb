class BorrowingsController < ApplicationController
  before_action :require_librarian
  before_action :set_borrowing, only: [:show, :edit, :update, :destroy, :mark_returned, :mark_overdue]

  def index
    @borrowings = Borrowing.includes(:book, :member).all
  end

  def show
  end

  def new
    @borrowing = Borrowing.new
    @books = Book.where(available: true)
    @members = Member.where(active: true)
  end

  def create
    @borrowing = Borrowing.new(borrowing_params)
    @borrowing.borrowed_date = Date.current
    @borrowing.due_date = Date.current + 14.days # 2 weeks borrowing period
    @borrowing.status = 'borrowed'
    
    if @borrowing.save
      # Mark book as unavailable
      @borrowing.book.update(available: false)
      redirect_to @borrowing, notice: 'Book was successfully borrowed.'
    else
      @books = Book.where(available: true)
      @members = Member.where(active: true)
      render :new
    end
  end

  def edit
    @books = Book.all
    @members = Member.where(active: true)
  end

  def update
    if @borrowing.update(borrowing_params)
      redirect_to @borrowing, notice: 'Borrowing was successfully updated.'
    else
      @books = Book.all
      @members = Member.where(active: true)
      render :edit
    end
  end

  def destroy
    # Mark book as available again if borrowing is deleted
    @borrowing.book.update(available: true) if @borrowing.status == 'borrowed'
    @borrowing.destroy
    redirect_to borrowings_url, notice: 'Borrowing was successfully deleted.'
  end

  def mark_returned
    @borrowing.update(status: 'returned', returned_date: Date.current)
    @borrowing.book.update(available: true)
    redirect_to @borrowing, notice: 'Book was successfully returned.'
  end

  def mark_overdue
    @borrowing.update(status: 'overdue')
    redirect_to @borrowing, notice: 'Borrowing marked as overdue.'
  end

  def overdue
    @overdue_borrowings = Borrowing.where(status: 'overdue').includes(:book, :member)
  end

  private

  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
  end

  def borrowing_params
    params.require(:borrowing).permit(:book_id, :member_id, :borrowed_date, :due_date, :returned_date, :status)
  end
end
