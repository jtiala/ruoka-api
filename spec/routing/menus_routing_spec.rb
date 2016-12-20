require "rails_helper"

RSpec.describe MenusController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/menus").to route_to("menus#index")
    end

    it "routes to #new" do
      expect(:get => "/menus/new").to route_to("menus#new")
    end

    it "routes to #show" do
      expect(:get => "/menus/1").to route_to("menus#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/menus/1/edit").to route_to("menus#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/menus").to route_to("menus#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/menus/1").to route_to("menus#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/menus/1").to route_to("menus#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/menus/1").to route_to("menus#destroy", :id => "1")
    end

  end
end
