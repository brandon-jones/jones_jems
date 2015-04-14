class MyWork < ActiveRecord::Base
	has_many :pictures, as: :gallery, dependent: :destroy

	def cover?
		return self.picture_id.present? ? true : false
	end

	def cover
		return Picture.find_by_id(self.picture_id) if self.cover?
		return nil
	end
end
