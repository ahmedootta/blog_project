class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :author, null: false, foreign_key: { to_table: :users } # Reference to users table,
      # already add index on foreign key, so don't add index function >> error 
      t.references :tag, null: false, foreign_key: { to_table: :tags }
      t.timestamps
    end
  end
end
