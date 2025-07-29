class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true, inclusion: { in: %w[librarian member] }

  # Add these relationships
  has_many :book_requests, foreign_key: "requested_by_id", dependent: :destroy
  has_many :approved_requests, class_name: "BookRequest", foreign_key: "approved_by_id"

  before_validation :set_default_role, on: :create

  def librarian?
    role == "librarian"
  end

  def member?
    role == "member"
  end

  # Add this method
  def pending_requests_count
    book_requests.pending.count
  end

  private

  def set_default_role
    self.role ||= "member"
  end
end
