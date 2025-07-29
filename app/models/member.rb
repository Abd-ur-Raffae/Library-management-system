class Member < ApplicationRecord
  has_many :borrowings, dependent: :destroy
  has_many :books, through: :borrowings
  has_many :book_requests, dependent: :destroy  # Add this line

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
  validates :membership_date, presence: true
  validates :active, inclusion: { in: [ true, false ] }
end
