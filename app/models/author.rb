class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
end
