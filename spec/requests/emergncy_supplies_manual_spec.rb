require 'rails_helper'

RSpec.describe "EmergncySuppliesManuals", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/emergncy_supplies_manual/index"
      expect(response).to have_http_status(:success)
    end
  end

end
