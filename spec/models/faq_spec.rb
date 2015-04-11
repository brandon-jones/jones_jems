require 'rails_helper'

RSpec.describe Faq, type: :model do
  context "validators" do
   	it "expects a question to be present" do
   		faq = FactoryGirl.build(:faq, question: nil)
   		expect(faq.save).to be_falsy
   		faq.question = 'question'
   		expect(faq.save).to be_truthy
   	end

   	it "expects an answer to be present" do
   		faq = FactoryGirl.build(:faq, answer: nil)
   		expect(faq.save).to be_falsy
   		faq.answer = 'real answer'
   		expect(faq.save).to be_truthy
   	end

   	it "expects both a question and answer to be present" do
   		faq = FactoryGirl.build(:faq, question: '', answer: '')
   		expect(faq.save).to be_falsy
   		faq.question = 'question'
   		expect(faq.save).to be_falsy
   		faq.answer = 'yes'
   		expect(faq.save).to be_truthy
   	end
	end
end
