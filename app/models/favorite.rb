class Favorite < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :post #:title, :body
end
