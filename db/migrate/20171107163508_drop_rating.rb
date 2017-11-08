class DropRating < ActiveRecord::Migration[5.1]
  def change
    drop_table :rates
    drop_table :rating_caches
  end
end
