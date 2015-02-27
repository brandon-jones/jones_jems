class MyWork < ActiveRecord::Base
	validates_presence_of :title
	has_many :pictures, :dependent => :destroy
end
