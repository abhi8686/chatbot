require 'rails_helper'

RSpec.describe "educational_details/edit", type: :view do
  before(:each) do
    @educational_detail = assign(:educational_detail, EducationalDetail.create!(
      :collageName => "MyString",
      :courseName => "MyString",
      :location => "MyString"
    ))
  end

  it "renders the edit educational_detail form" do
    render

    assert_select "form[action=?][method=?]", educational_detail_path(@educational_detail), "post" do

      assert_select "input#educational_detail_collageName[name=?]", "educational_detail[collageName]"

      assert_select "input#educational_detail_courseName[name=?]", "educational_detail[courseName]"

      assert_select "input#educational_detail_location[name=?]", "educational_detail[location]"
    end
  end
end
