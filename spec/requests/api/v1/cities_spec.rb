require 'rails_helper'

RSpec.describe 'API::V1::Cities', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/cities/index'
      expect(response).to have_http_status(:success)
    end
  end
end
