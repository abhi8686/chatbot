require 'rails_helper'

RSpec.describe "work_experiences/show", type: :view do
  before(:each) do
    @work_experience = assign(:work_experience, WorkExperience.create!(
      :companyName => "Company Name",
      :designation => "Designation",
      :location => "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Company Name/)
    expect(rendered).to match(/Designation/)
    expect(rendered).to match(/Location/)
  end
end
