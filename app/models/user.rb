class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,format: {with:VALID_EMAIL_REGEX}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
