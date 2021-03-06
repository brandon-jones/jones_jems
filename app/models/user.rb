class User < ActiveRecord::Base
	validates_presence_of :email
  validates_uniqueness_of :email
  validates :password,length: { minimum: 6 }
  validates_confirmation_of :password
  before_save :fix_case

  has_secure_password

  def fix_case
  	self.email = self.email.downcase
  end

end
