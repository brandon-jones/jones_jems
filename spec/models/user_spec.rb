require 'rails_helper'

RSpec.describe User, type: :model do
  context "methods" do
  	it "expects the email to be downcased" do
			user = FactoryGirl.create(:user, email: 'TEST@TEST.COM')
			expect(user.email).to eq('test@test.com')
		end
	end

  context "validations" do
		it "expects a password to be at least 6 characters" do
			user = FactoryGirl.build(:user, password: 'fail')
			expect(user.save).to be_falsy
			user.update_attribute(:password, 'password')
			expect(user.save).to be_truthy
		end

		it "expects an email to be unique" do
			user = FactoryGirl.create(:user)
			user2 = FactoryGirl.build(:user, email: user.email)
			expect(user2.save).to be_falsy
			user2.email = 'new@new.com'
			expect(user2.save).to be_truthy
		end

		it "expects an email to not be nil" do
			user = FactoryGirl.build(:user, email: nil)
			expect(user.save).to be_falsy
			user.email = "valid@valid.com"
			expect(user.save).to be_truthy
		end

		it "expects an email to be present" do
			user = FactoryGirl.build(:user, email: '')
			expect(user.save).to be_falsy
			user.email = "valid@valid.com"
			expect(user.save).to be_truthy
		end

		it "expects password confirmation to match" do
			user = FactoryGirl.build(:user, password: 'password', password_confirmation: 'longenough')
			expect(user.save).to be_falsy
			user.password_confirmation = 'password'
			expect(user.save).to be_truthy
		end
	end

	context "validations" do
		it "expects the email to lowercased before saving" do
			user = FactoryGirl.build(:user, email: 'I@RULE.YOU')
			expect(user.email).to eq('I@RULE.YOU')
			user.save
			expect(user.email).to eq('i@rule.you')
		end
	end
end
