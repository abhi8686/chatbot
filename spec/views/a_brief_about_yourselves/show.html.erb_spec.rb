require 'rails_helper'

RSpec.describe "a_brief_about_yourselves/show", type: :view do
  before(:each) do
    @a_brief_about_yourself = assign(:a_brief_about_yourself, ABriefAboutYourself.create!(
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
