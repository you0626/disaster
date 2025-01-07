require 'rails_helper'

RSpec.describe "Earthquakes", type: :request do
  describe "GET /forecast" do
    it "returns http success" do
      get "/earthquakes/forecast"
      expect(response).to have_http_status(:success)
    end
  end

end
