class MyWork < ActiveRecord::Base
	has_many :pictures, as: :gallery, dependent: :destroy
  before_save :set_tags

	def cover?
		return self.picture_id.present? ? true : false
	end

	def cover
		return Picture.find_by_id(self.picture_id) if self.cover?
		return nil
	end

  private

  def set_tags
    tags = self.tags.split(',').map { |tag| tag.downcase.strip }
    self.tags = tags.join(', ')
  end
end
