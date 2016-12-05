require 'rails_helper'

RSpec.describe "educational_details/index", type: :view do
  before(:each) do
    assign(:educational_details, [
      EducationalDetail.create!(
        :collageName => "Collage Name",
        :courseName => "Course Name",
        :location => "Location"
      ),
      EducationalDetail.create!(
        :collageName => "Collage Name",
        :courseName => "Course Name",
        :location => "Location"
      )
    ])
  end

  it "renders a list of educational_details" do
    render
    assert_select "tr>td", :text => "Collage Name".to_s, :count => 2
    assert_select "tr>td", :text => "Course Name".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
