require "rails_helper"

RSpec.describe EducationalDetailsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/educational_details").to route_to("educational_details#index")
    end

    it "routes to #new" do
      expect(:get => "/educational_details/new").to route_to("educational_details#new")
    end

    it "routes to #show" do
      expect(:get => "/educational_details/1").to route_to("educational_details#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/educational_details/1/edit").to route_to("educational_details#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/educational_details").to route_to("educational_details#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/educational_details/1").to route_to("educational_details#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/educational_details/1").to route_to("educational_details#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/educational_details/1").to route_to("educational_details#destroy", :id => "1")
    end

  end
end
