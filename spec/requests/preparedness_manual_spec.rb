require 'rails_helper'

RSpec.describe "PreparednessManuals", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/preparedness_manual/index"
      expect(response).to have_http_status(:success)
    end
  end

end
