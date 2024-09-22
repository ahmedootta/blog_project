class Post < ApplicationRecord
  # Associations..
  belongs_to :author, class_name: 'User'
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :comments, through: :comments
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :author_id, presence: true
end
