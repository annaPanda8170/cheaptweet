class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname ,presence: true
  has_many :tweets
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
