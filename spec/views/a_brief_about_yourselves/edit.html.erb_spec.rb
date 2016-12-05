require 'rails_helper'

RSpec.describe "a_brief_about_yourselves/edit", type: :view do
  before(:each) do
    @a_brief_about_yourself = assign(:a_brief_about_yourself, ABriefAboutYourself.create!(
      :body => "MyText"
    ))
  end

  it "renders the edit a_brief_about_yourself form" do
    render

    assert_select "form[action=?][method=?]", a_brief_about_yourself_path(@a_brief_about_yourself), "post" do

      assert_select "textarea#a_brief_about_yourself_body[name=?]", "a_brief_about_yourself[body]"
    end
  end
end
