require 'rails_helper'

RSpec.describe "statuses/edit", type: :view do
  before(:each) do
    @status = assign(:status, Status.create!(
      :name => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit status form" do
    render

    assert_select "form[action=?][method=?]", status_path(@status), "post" do

      assert_select "input#status_name[name=?]", "status[name]"

      assert_select "textarea#status_content[name=?]", "status[content]"
    end
  end
end
