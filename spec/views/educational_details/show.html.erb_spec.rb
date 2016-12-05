require 'rails_helper'

RSpec.describe "educational_details/show", type: :view do
  before(:each) do
    @educational_detail = assign(:educational_detail, EducationalDetail.create!(
      :collageName => "Collage Name",
      :courseName => "Course Name",
      :location => "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Collage Name/)
    expect(rendered).to match(/Course Name/)
    expect(rendered).to match(/Location/)
  end
end
