class Picture < ActiveRecord::Base
	belongs_to :my_work

  has_attached_file :image, 
  	:styles => {:thumb => '100x100', :medium => '300x300', :large => '600x600'}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  crop_attached_file :image

  def thumbnail
  	return self.image.url(:thumb)
  end

  def large
    return self.image.url(:large)
  end

  def medium
    return self.image.url(:medium)
  end

  def cover?
    return self.my_work.cover == self.id
  end

  def image_file_name_no_ext
  	return File.basename(self.image_file_name,File.extname(self.image_file_name))
  end
end
