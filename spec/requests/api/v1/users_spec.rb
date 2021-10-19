require 'rails_helper'

RSpec.describe 'API::V1::Users', type: :request do
  # initialize test data
  let!(:users) { create_list(:user, 5) }

  describe 'GET /index' do
    # make HTTP get request before each example
    before { get '/api/v1/users' }

    it 'returns a list of all users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to be > 4
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
      expect(response).to have_http_status(200)
    end
  end
end