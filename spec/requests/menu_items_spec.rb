require 'rails_helper'

RSpec.describe "MenuItems", type: :request do
  describe "GET /menu_items" do
    it "works! (now write some real specs)" do
      get menu_items_path
      expect(response).to have_http_status(200)
    end
  end
end
