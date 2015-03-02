module Paperclip
  class Rotator < Thumbnail
    def initialize(file, options = {}, attachment = nil)
      options[:auto_orient] = false
      super
    end

    def transformation_command
      if rotate_command
        "#{rotate_command} #{super.join(' ')}"
      else
        super
      end
    end

    def rotate_command
      target = @attachment.instance
      if target.rotation.present?
        " -rotate #{target.rotation}"
      end
    end
  end
end

class Picture < ActiveRecord::Base
	belongs_to :my_work

  has_attached_file :image, 
  	:styles => {:thumb => '100x100', :medium => '300x300', :large => '600x600'}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  crop_attached_file :image

  def thumbnail
  	return self.image.url(:thumb)
  end

  def image_file_name_no_ext
  	return File.basename(self.image_file_name,File.extname(self.image_file_name))
  end
end
