class CreateAverageCaches < ActiveRecord::Migration[5.1]

  def self.up
    create_table :average_caches do |t|
      t.belongs_to :rater
      t.belongs_to :rateable, :polymorphic => true
      t.float :avg, :null => false
      t.timestamps
    end

    add_index :average_caches, [:rater_id, :rateable_id, :rateable_type],
      :name => 'my_index'
  end

  def self.down
    drop_table :average_caches
  end

end

