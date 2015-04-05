require 'rails_helper'

RSpec.describe "my_works/edit", type: :view do
  before(:each) do
    @my_work = assign(:my_work, MyWork.create!(
      :title => "MyString",
      :tags => "MyString",
      :description => "MyText",
      :cover => 1
    ))
  end

  it "renders the edit my_work form" do
    render

    assert_select "form[action=?][method=?]", my_work_path(@my_work), "post" do

      assert_select "input#my_work_title[name=?]", "my_work[title]"

      assert_select "input#my_work_tags[name=?]", "my_work[tags]"

      assert_select "textarea#my_work_description[name=?]", "my_work[description]"

      assert_select "input#my_work_cover[name=?]", "my_work[cover]"
    end
  end
end
