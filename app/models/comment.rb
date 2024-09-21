class Comment < ApplicationRecord
  belongs_to :post, class_name: 'Post'
  belongs_to :commenter, class_name: 'User'

  # validations
  validates :body, presence: true
  validates :post_id, presence: true
  validates :commenter_id, presence: true
end
