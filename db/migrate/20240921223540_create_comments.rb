class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :post, null: false, foreign_key: {to_table: :posts}
      t.references :commenter, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
