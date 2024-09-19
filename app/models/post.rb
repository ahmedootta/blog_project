class Post < ApplicationRecord
  # Associations..
  belongs_to :author, class_name: 'User'
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, presence: true
  validates :body, presence: true
  validates :author_id, presence: true
end
