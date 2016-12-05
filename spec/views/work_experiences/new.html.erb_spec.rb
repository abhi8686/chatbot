require 'rails_helper'

RSpec.describe "work_experiences/new", type: :view do
  before(:each) do
    assign(:work_experience, WorkExperience.new(
      :companyName => "MyString",
      :designation => "MyString",
      :location => "MyString"
    ))
  end

  it "renders new work_experience form" do
    render

    assert_select "form[action=?][method=?]", work_experiences_path, "post" do

      assert_select "input#work_experience_companyName[name=?]", "work_experience[companyName]"

      assert_select "input#work_experience_designation[name=?]", "work_experience[designation]"

      assert_select "input#work_experience_location[name=?]", "work_experience[location]"
    end
  end
end
