class Post < ActiveRecord::Base
  attr_accessible :admin_id, :name, :url
  belongs_to :admin
end