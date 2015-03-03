class MyWork < ActiveRecord::Base
	has_many :pictures, :dependent => :destroy

	def cover?
		return self.picture_id .present? ? true : false
	end

	def cover
		unless self.picture_id
			if pics = Picture.where(my_work_id: self.id).where(cropped: true)
				self.update_attribute(:picture_id, pics.sample.id)
			else
				return nil
			end
		end
		return Picture.find_by_id(self.picture_id)
	end
end
