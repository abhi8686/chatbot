require "rails_helper"

RSpec.describe ABriefAboutYourselvesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/a_brief_about_yourselves").to route_to("a_brief_about_yourselves#index")
    end

    it "routes to #new" do
      expect(:get => "/a_brief_about_yourselves/new").to route_to("a_brief_about_yourselves#new")
    end

    it "routes to #show" do
      expect(:get => "/a_brief_about_yourselves/1").to route_to("a_brief_about_yourselves#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/a_brief_about_yourselves/1/edit").to route_to("a_brief_about_yourselves#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/a_brief_about_yourselves").to route_to("a_brief_about_yourselves#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/a_brief_about_yourselves/1").to route_to("a_brief_about_yourselves#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/a_brief_about_yourselves/1").to route_to("a_brief_about_yourselves#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/a_brief_about_yourselves/1").to route_to("a_brief_about_yourselves#destroy", :id => "1")
    end

  end
end
