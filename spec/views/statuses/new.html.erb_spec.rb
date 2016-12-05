require 'rails_helper'

RSpec.describe "statuses/new", type: :view do
  before(:each) do
    assign(:status, Status.new(
      :name => "MyString",
      :content => "MyText"
    ))
  end

  it "renders new status form" do
    render

    assert_select "form[action=?][method=?]", statuses_path, "post" do

      assert_select "input#status_name[name=?]", "status[name]"

      assert_select "textarea#status_content[name=?]", "status[content]"
    end
  end
end
