class MyWork < ActiveRecord::Base
	has_many :pictures, as: :gallery, dependent: :destroy

	def cover?
		return self.picture_id .present? ? true : false
	end

	def cover
		unless self.picture_id
			assign_cover
		end
		if pic = Picture.find_by_id(self.picture_id)
			return pic
		else
			assign_cover
			if pic = Picture.find_by_id(self.picture_id)
				return pic
			else
				return nil
			end
		end
	end

	def assign_cover
		pics = self.pictures.where(cropped: true)
		if pics.length > 0
			self.update_attribute(:picture_id, pics.sample.id)
		else
			nil
		end
	end
end
