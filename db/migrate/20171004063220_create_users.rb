class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :gender
      t.string :password_digest
      t.string :provider
      t.string :oauth_token
      t.bigint :oauth_expires_at

      t.timestamps
    end
  end
end
