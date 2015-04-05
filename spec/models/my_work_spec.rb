require 'rails_helper'

RSpec.describe MyWork, type: :model do
  context "methods" do
   	before(:each) do
    	@my_work = FactoryGirl.create(:my_work)
  	end
		it "expects a true or false if picture_id present" do
			expect(@my_work.cover?).to eq(false)
			@my_work.update_attribute(:picture_id, 1)
			expect(@my_work.cover?).to eq(true)
		end

		it "expects a nil to be returned if work has no pics" do
			expect(@my_work.cover).to eq(nil)
		end

		it "expects a Picture returned if one present but not set" do
			pic = FactoryGirl.create(:picture, my_work_id: @my_work.id, cropped: true)
			expect(@my_work.cover).to eq(pic)
		end

		it "expects the correct Picture if one is set" do
			pic = FactoryGirl.create(:picture, my_work_id: @my_work.id, cropped: true)
			@my_work.update_attribute(:picture_id, pic.id)
			expect(@my_work.cover).to eq(pic)
		end
	end
end
