class Book < ApplicationRecord
  belongs_to :author
  has_many :borrowings, dependent: :destroy
  has_many :members, through: :borrowings

  validates :title, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :publication_year, presence: true
  validates :available, inclusion: { in: [ true, false ] }
end
