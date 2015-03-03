require 'rails_helper'

RSpec.describe "my_works/index", type: :view do
  before(:each) do
    assign(:my_works, [
      MyWork.create!(
        :title => "Title",
        :tags => "Tags",
        :description => "MyText",
        :cover => 1
      ),
      MyWork.create!(
        :title => "Title",
        :tags => "Tags",
        :description => "MyText",
        :cover => 1
      )
    ])
  end

  it "renders a list of my_works" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
