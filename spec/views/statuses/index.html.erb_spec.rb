require 'rails_helper'

RSpec.describe "statuses/index", type: :view do
  before(:each) do
    assign(:statuses, [
      Status.create!(
        :name => "Name",
        :content => "MyText"
      ),
      Status.create!(
        :name => "Name",
        :content => "MyText"
      )
    ])
  end

  it "renders a list of statuses" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
