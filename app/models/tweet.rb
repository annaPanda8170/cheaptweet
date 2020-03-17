class Tweet < ApplicationRecord
  validates :text ,presence: true
  belongs_to :user
  has_many :comments
  def self.search(search)
    if search
      Tweet.where('text LIKE(?)', "%#{search}%").includes(:user)
    else
      Tweet.all.includes(:user)
    end
  end
end
