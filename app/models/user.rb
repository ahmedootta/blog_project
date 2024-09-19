class User < ApplicationRecord
    has_secure_password
    # Associations..
    has_many :posts, foreign_key: 'author_id', dependent: :destroy 

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 6}
  end