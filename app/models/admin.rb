class Admin < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  before_save { |admin| admin.email = email.downcase }
  before_save :create_remember_token

  has_many :posts
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true

  private
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
