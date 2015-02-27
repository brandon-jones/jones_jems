require "rails_helper"

RSpec.describe MyWorksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/my_works").to route_to("my_works#index")
    end

    it "routes to #new" do
      expect(:get => "/my_works/new").to route_to("my_works#new")
    end

    it "routes to #show" do
      expect(:get => "/my_works/1").to route_to("my_works#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/my_works/1/edit").to route_to("my_works#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/my_works").to route_to("my_works#create")
    end

    it "routes to #update" do
      expect(:put => "/my_works/1").to route_to("my_works#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/my_works/1").to route_to("my_works#destroy", :id => "1")
    end

  end
end
