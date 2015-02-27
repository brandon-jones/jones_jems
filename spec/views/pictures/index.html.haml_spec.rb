require 'rails_helper'

RSpec.describe "pictures/index", type: :view do
  before(:each) do
    assign(:pictures, [
      Picture.create!(
        :description => "Description",
        :my_work_id => 1,
        :image => ""
      ),
      Picture.create!(
        :description => "Description",
        :my_work_id => 1,
        :image => ""
      )
    ])
  end

  it "renders a list of pictures" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
