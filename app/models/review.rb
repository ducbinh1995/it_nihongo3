class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :book_id, presence: true
end
