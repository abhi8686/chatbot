require 'rails_helper'

RSpec.describe "educational_details/new", type: :view do
  before(:each) do
    assign(:educational_detail, EducationalDetail.new(
      :collageName => "MyString",
      :courseName => "MyString",
      :location => "MyString"
    ))
  end

  it "renders new educational_detail form" do
    render

    assert_select "form[action=?][method=?]", educational_details_path, "post" do

      assert_select "input#educational_detail_collageName[name=?]", "educational_detail[collageName]"

      assert_select "input#educational_detail_courseName[name=?]", "educational_detail[courseName]"

      assert_select "input#educational_detail_location[name=?]", "educational_detail[location]"
    end
  end
end
