class AddTagIdToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :tag_id, :integer
  end
end
