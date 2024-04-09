class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,format: {with:VALID_EMAIL_REGEX}
  validates :password,length:{minimum:8},format:{with:/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[.!@#$%^&*])/}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
