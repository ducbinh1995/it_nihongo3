class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :book_id, presence: true

  acts_as_notifiable :users,
    targets: ->(review, key) {
      (review.book.bookmark_users.to_a).uniq
    },
    notifiable_path: :review_notifiable_path,
    tracked: { only: [:create] }

  def review_notifiable_path
    book_path id: book.id
  end
end
