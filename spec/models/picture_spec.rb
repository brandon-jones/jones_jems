require 'rails_helper'

RSpec.describe Picture, type: :model do
	before(:each) do
		@picture = FactoryGirl.create(:picture)
	end

  context "paperclip" do
  	it "expects the file name to be correct" do
  		expect(@picture.image_file_name).to eq('hat.jpg')
  	end

  	it "expects the file type to be correct" do
  		expect(@picture.image_content_type).to eq('image/png')
  	end
  end

  context "methods" do
  	it "expects the url the thumbnail image" do
  		expect(@picture.image.url(:thumb)).to include('/thumb/')
  	end

  	it "expects the url the medium image" do
  		expect(@picture.image.url(:medium)).to include('/medium/')

  	end

  	it "expect the url to the large image" do
  		expect(@picture.image.url(:large)).to include('/large/')
  	end

  	it "expect true if this pic is the cover of its MyWork" do
  		my_work = FactoryGirl.create(:my_work, picture_id: @picture.id)
  		@picture.update_attribute(:my_work_id, my_work.id)
  		expect(@picture.cover?).to eq(true)
  	end

  	it "expects false if this pic is not the cover of its MyWork" do
  		my_work = FactoryGirl.create(:my_work)
  		@picture.update_attribute(:my_work_id, my_work.id)
  		expect(@picture.cover?).to eq(false)
  	end

  	it "expects file name without expection" do
  		expect(@picture.image_file_name_no_ext).to eq('hat')
  	end

  	it "expects file name _ id" do
  		expect(@picture.name_id).to eq('hat_'+@picture.id.to_s)
  	end
  end
end
