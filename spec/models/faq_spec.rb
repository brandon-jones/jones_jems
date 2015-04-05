require 'rails_helper'

RSpec.describe Faq, type: :model do
  context "validators" do
   	it "expect a question to be present" do
   		faq = FactoryGirl.build(:faq, question: nil)
   		expect(faq.save).to eq(false)
   		faq.question = 'question'
   		expect(faq.save).to eq(true)
   	end

   	it "expects an answer to be present" do
   		faq = FactoryGirl.build(:faq, answer: nil)
   		expect(faq.save).to eq(false)
   		faq.answer = 'real answer'
   		expect(faq.save).to eq(true)
   	end

   	it "expects both a question and answer to be present" do
   		faq = FactoryGirl.build(:faq, question: '', answer: '')
   		expect(faq.save).to eq(false)
   		faq.question = 'question'
   		expect(faq.save).to eq(false)
   		faq.answer = 'yes'
   		expect(faq.save).to eq(true)
   	end
	end
end
