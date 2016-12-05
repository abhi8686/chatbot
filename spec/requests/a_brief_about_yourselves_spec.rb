require 'rails_helper'

RSpec.describe "ABriefAboutYourselves", type: :request do
  describe "GET /a_brief_about_yourselves" do
    it "works! (now write some real specs)" do
      get a_brief_about_yourselves_path
      expect(response).to have_http_status(200)
    end
  end
end
