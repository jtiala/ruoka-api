require 'rails_helper'

RSpec.describe "Menus", type: :request do
  describe "GET /menus" do
    it "works! (now write some real specs)" do
      get menus_path
      expect(response).to have_http_status(200)
    end
  end
end
