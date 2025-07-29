class Borrowing < ApplicationRecord
  belongs_to :book
  belongs_to :member, optional: true  # This should already be there

  validates :borrowed_date, presence: true
  validates :due_date, presence: true
  validates :status, presence: true
  validates :status, inclusion: { in: %w[borrowed returned overdue] }

  validate :due_date_after_borrowed_date

  scope :active, -> { where(status: "borrowed") }
  scope :overdue, -> { where(status: "overdue") }
  scope :returned, -> { where(status: "returned") }

  private

  def due_date_after_borrowed_date
    return unless borrowed_date && due_date

    errors.add(:due_date, "must be after borrowed date") if due_date < borrowed_date
  end
end
