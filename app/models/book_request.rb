class BookRequest < ApplicationRecord
  belongs_to :book
  belongs_to :member, optional: true
  belongs_to :requested_by, class_name: "User"
  belongs_to :approved_by, class_name: "User", optional: true

  validates :requested_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending approved rejected expired] }
  validates :reason, presence: true, length: { minimum: 10 }
  validates :needed_by_date, presence: true
  validate :needed_by_date_must_be_future
  validate :book_must_be_available, on: :create
  validate :no_duplicate_pending_requests, on: :create

  before_validation :set_defaults, on: :create

  scope :pending, -> { where(status: "pending") }
  scope :approved, -> { where(status: "approved") }
  scope :rejected, -> { where(status: "rejected") }
  scope :for_book, ->(book) { where(book: book) }
  scope :by_user, ->(user) { where(requested_by: user) }

  def approve!(librarian, create_borrowing: true)
    transaction do
      update!(
        status: "approved",
        approved_by: librarian,
        approved_date: Date.current
      )

      if create_borrowing && book.available?
        borrowing = Borrowing.create!(
          book: book,
          member: member,
          borrowed_date: Date.current,
          due_date: needed_by_date || (Date.current + 14.days),
          status: "borrowed"
        )
        book.update!(available: false)
      end

      # Remove other pending requests for the same book
      BookRequest.pending.for_book(book).where.not(id: id).update_all(
        status: "expired",
        approved_date: Date.current
      )
    end
  end

  def reject!(librarian, reason)
    update!(
      status: "rejected",
      approved_by: librarian,
      approved_date: Date.current,
      rejection_reason: reason
    )
  end

  def can_be_approved?
    pending? && book.available?
  end

  def pending?
    status == "pending"
  end

  def approved?
    status == "approved"
  end

  def rejected?
    status == "rejected"
  end

  private

  def set_defaults
    self.requested_date ||= Date.current
    self.status ||= "pending"
  end

  def needed_by_date_must_be_future
    return unless needed_by_date

    if needed_by_date <= Date.current
      errors.add(:needed_by_date, "must be in the future")
    end
  end

  def book_must_be_available
    return unless book

    unless book.available?
      errors.add(:book, "is not available for borrowing")
    end
  end

  def no_duplicate_pending_requests
    return unless book && requested_by

    if BookRequest.pending.for_book(book).by_user(requested_by).exists?
      errors.add(:book, "already has a pending request from you")
    end
  end
end
