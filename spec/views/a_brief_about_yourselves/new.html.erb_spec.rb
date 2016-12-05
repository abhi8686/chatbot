require 'rails_helper'

RSpec.describe "a_brief_about_yourselves/new", type: :view do
  before(:each) do
    assign(:a_brief_about_yourself, ABriefAboutYourself.new(
      :body => "MyText"
    ))
  end

  it "renders new a_brief_about_yourself form" do
    render

    assert_select "form[action=?][method=?]", a_brief_about_yourselves_path, "post" do

      assert_select "textarea#a_brief_about_yourself_body[name=?]", "a_brief_about_yourself[body]"
    end
  end
end
