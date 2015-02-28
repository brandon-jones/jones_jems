class Picture < ActiveRecord::Base
	belongs_to :my_work

  has_attached_file :image, 
  	:styles => {:thumb => '100x100', :medium => '300x300', :large => '600x600'}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  crop_attached_file :image
end
