class RemoveTagIdFromPosts < ActiveRecord::Migration[7.2]
  def change
    remove_column :posts, :tag_id, :integer
  end
end
