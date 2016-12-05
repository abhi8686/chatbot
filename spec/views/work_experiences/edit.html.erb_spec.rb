require 'rails_helper'

RSpec.describe "work_experiences/edit", type: :view do
  before(:each) do
    @work_experience = assign(:work_experience, WorkExperience.create!(
      :companyName => "MyString",
      :designation => "MyString",
      :location => "MyString"
    ))
  end

  it "renders the edit work_experience form" do
    render

    assert_select "form[action=?][method=?]", work_experience_path(@work_experience), "post" do

      assert_select "input#work_experience_companyName[name=?]", "work_experience[companyName]"

      assert_select "input#work_experience_designation[name=?]", "work_experience[designation]"

      assert_select "input#work_experience_location[name=?]", "work_experience[location]"
    end
  end
end
