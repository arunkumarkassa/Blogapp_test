class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :articles, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with:VALID_EMAIL_REGEX}
  validates :password, presence: true, confirmation: true, length:{minimum:8},format:{with:/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[.!@#$%^&*])/, message: " must include at least one number, lowercase letter, uppercase letter, and special character"}
  validates :password_confirmation, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
