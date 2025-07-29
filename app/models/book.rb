class Book < ApplicationRecord
  belongs_to :author
  has_many :borrowings, dependent: :destroy
  has_many :members, through: :borrowings
  has_many :book_requests, dependent: :destroy  # Add this line

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :publication_year, presence: true
  validates :available, inclusion: { in: [ true, false ] }

  # Add this method
  def pending_requests_count
    book_requests.pending.count
  end
end
