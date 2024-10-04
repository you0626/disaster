require 'rails_helper'

RSpec.describe "TyphoonManuals", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/typhoon_manual/index"
      expect(response).to have_http_status(:success)
    end
  end

end
