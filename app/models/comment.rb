class Comment < ActiveRecord::Base
  attr_accessible :author, :content, :priority, :votes
  belongs_to :post
end
