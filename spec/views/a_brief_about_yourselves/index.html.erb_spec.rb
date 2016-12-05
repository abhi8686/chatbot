require 'rails_helper'

RSpec.describe "a_brief_about_yourselves/index", type: :view do
  before(:each) do
    assign(:a_brief_about_yourselves, [
      ABriefAboutYourself.create!(
        :body => "MyText"
      ),
      ABriefAboutYourself.create!(
        :body => "MyText"
      )
    ])
  end

  it "renders a list of a_brief_about_yourselves" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
