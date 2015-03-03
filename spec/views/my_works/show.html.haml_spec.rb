require 'rails_helper'

RSpec.describe "my_works/show", type: :view do
  before(:each) do
    @my_work = assign(:my_work, MyWork.create!(
      :title => "Title",
      :tags => "Tags",
      :description => "MyText",
      :cover => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Tags/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
  end
end
