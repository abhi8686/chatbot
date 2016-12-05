require 'rails_helper'

RSpec.describe "work_experiences/index", type: :view do
  before(:each) do
    assign(:work_experiences, [
      WorkExperience.create!(
        :companyName => "Company Name",
        :designation => "Designation",
        :location => "Location"
      ),
      WorkExperience.create!(
        :companyName => "Company Name",
        :designation => "Designation",
        :location => "Location"
      )
    ])
  end

  it "renders a list of work_experiences" do
    render
    assert_select "tr>td", :text => "Company Name".to_s, :count => 2
    assert_select "tr>td", :text => "Designation".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
