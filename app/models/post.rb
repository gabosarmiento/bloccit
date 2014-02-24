class Post < ActiveRecord::Base
  attr_accessible :body, :title, :topic, :image
  has_many :comments
  belongs_to :user
  belongs_to :topic

  mount_uploader :image, ImageUploader

  default_scope order('created_at DESC')
  
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true 
  validates :image, format: { with: %r{\.gif|jpg|png}i, message: 'must be a url for gif, jpg, or png image.' } , presence: true
end
