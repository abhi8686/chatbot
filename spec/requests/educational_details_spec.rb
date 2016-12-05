require 'rails_helper'

RSpec.describe "EducationalDetails", type: :request do
  describe "GET /educational_details" do
    it "works! (now write some real specs)" do
      get educational_details_path
      expect(response).to have_http_status(200)
    end
  end
end
