require 'rails_helper'

RSpec.describe "pictures/edit", type: :view do
  before(:each) do
    @picture = assign(:picture, Picture.create!(
      :description => "MyString",
      :my_work_id => 1,
      :image => ""
    ))
  end

  it "renders the edit picture form" do
    render

    assert_select "form[action=?][method=?]", picture_path(@picture), "post" do

      assert_select "input#picture_description[name=?]", "picture[description]"

      assert_select "input#picture_my_work_id[name=?]", "picture[my_work_id]"

      assert_select "input#picture_image[name=?]", "picture[image]"
    end
  end
end
