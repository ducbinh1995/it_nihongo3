class Like < ApplicationRecord
  belongs_to :review
  belongs_to :user

  acts_as_notifiable :users,
    targets: ->(like, key) {
      ([like.review.user] + like.review.liked_users.to_a - [like.user]).uniq
    },
    notifiable_path: :review_notifiable_path,
    tracked: { only: [:create] }

  def review_notifiable_path
    review_path id: review.id
  end
end
