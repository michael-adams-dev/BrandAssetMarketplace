class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_one :seller_profile, required: false

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :first_name, presence: true
  validates :first_name, length: { in: 1..40 }
  validates :last_name, presence: true
  validates :last_name, length: { in: 1..40 }
  validates :username, presence: true
  validates :username, length: { in: 1..30 }
  validates :email, uniqueness: true
end
