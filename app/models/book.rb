class Book < ApplicationRecord
  mount_uploader :image, PictureUploader
  ratyrate_rateable "original_score"

  has_many :reviews, dependent: :destroy

  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user


  def overall_ratings(book)
    array = Rate.where(rateable_id: id, rateable_type: 'Book')
    stars = array.map {|book| book.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end

  def avg_rating_dimension_original_score(book)
    array = Rate.where(rateable_id: id, rateable_type: 'Book').where(dimension: "original_score")
    stars = array.map {|book| book.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end
end
