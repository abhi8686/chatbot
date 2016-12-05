require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  #describe "GET #showStatuses" do
   # it "only shows the correct user's statuses" do
    #  get :show, id: users(:leo).profile_name
     # assigns(:statuses).each do |status|
      #	assert_equal user(:leo), status.user
     # end
    #end
  #end

end
