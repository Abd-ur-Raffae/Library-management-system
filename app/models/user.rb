class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true, inclusion: { in: %w[librarian member] }

  before_validation :set_default_role, on: :create

  def librarian?
    role == "librarian"
  end

  def member?
    role == "member"
  end

  private

  def set_default_role
    self.role ||= "member"
  end
end
