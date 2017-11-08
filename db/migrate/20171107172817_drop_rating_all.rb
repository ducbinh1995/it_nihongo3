class DropRatingAll < ActiveRecord::Migration[5.1]
  def change
    drop_table :rates
    drop_table :rating_caches
    drop_table :average_caches
    drop_table :overall_averages
  end
end
