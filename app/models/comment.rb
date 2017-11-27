class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user

  acts_as_notifiable :users,
    targets: ->(comment, key) {
      ([comment.review.user] + comment.review.commented_users.to_a - [comment.user]).uniq
    },
    notifiable_path: :review_notifiable_path,
    tracked: { only: [:create] }

  def review_notifiable_path
    review_path id: review.id
  end
end
