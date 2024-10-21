require 'rails_helper'

RSpec.describe "Supports", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/support/index"
      expect(response).to have_http_status(:success)
    end
  end

end
