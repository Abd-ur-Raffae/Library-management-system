class BookRequestsController < ApplicationController
  before_action :set_book_request, only: [ :show, :edit, :update, :destroy, :approve, :reject ]
  before_action :require_librarian, only: [ :index, :approve, :reject ]
  before_action :require_owner_or_librarian, only: [ :show, :edit, :update, :destroy ]

  def index
    @pending_requests = BookRequest.pending.includes(:book, :requested_by).order(:requested_date)
    @recent_requests = BookRequest.where.not(status: "pending").includes(:book, :requested_by, :approved_by).order(approved_date: :desc).limit(10)
  end

  def show
  end

  def new
    @book = Book.find(params[:book_id]) if params[:book_id]
    @book_request = BookRequest.new
    @books = Book.where(available: true)
  end

  def create
    @book_request = BookRequest.new(book_request_params)
    @book_request.requested_by = current_user

    if @book_request.save
      redirect_to @book_request, notice: "Book request was successfully created."
    else
      @books = Book.where(available: true)
      render :new
    end
  end

  def edit
  end

  def update
    if @book_request.update(book_request_params)
      redirect_to @book_request, notice: "Book request was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @book_request.destroy
    redirect_to book_requests_url, notice: "Book request was successfully cancelled."
  end

  def approve
  begin
    if @book_request.can_be_approved?
      @book_request.approve!(current_user)
      redirect_to book_requests_path, notice: "Book request approved successfully."
    else
      redirect_to book_requests_path, alert: "Cannot approve this request. Book may no longer be available."
    end
  rescue => e
    Rails.logger.error "Error approving request: #{e.message}"
    redirect_to book_requests_path, alert: "Error approving request: #{e.message}"
  end
end



  def reject
    rejection_reason = params[:rejection_reason] || "No reason provided"
    @book_request.reject!(current_user, rejection_reason)
    redirect_to book_requests_path, notice: "Book request rejected."
  end

  # Member's own requests
  def my_requests
    @pending_requests = current_user.book_requests.pending.includes(:book).order(:requested_date)
    @processed_requests = current_user.book_requests.where.not(status: "pending").includes(:book, :approved_by).order(approved_date: :desc)
  end

  private

  def set_book_request
    @book_request = BookRequest.find(params[:id])
  end

  def book_request_params
    params.require(:book_request).permit(:book_id, :needed_by_date, :reason)
  end

  def require_owner_or_librarian
    unless current_user.librarian? || @book_request.requested_by == current_user
      redirect_to root_path, alert: "Access denied."
    end
  end
end
