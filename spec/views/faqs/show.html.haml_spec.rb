require 'rails_helper'

RSpec.describe "faqs/show", :type => :view do
  before(:each) do
    @faq = assign(:faq, Faq.create!(
      :question => "MyText",
      :answer => "Answer"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Answer/)
  end
end
