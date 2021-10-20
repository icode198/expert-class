require 'rails_helper'

RSpec.describe 'API::V1::Sessions', type: :request do
  describe 'POST /api/v1/sign_in' do
    # initialize test data
    let!(:users) { create_list(:user, 5) }
    let(:existing_username) { { user: { username: users.first.username } } }
    let(:non_existing_username) { { user: { username: 'unexistent_user' } } }

    context 'when the user exists in the database' do
      # make HTTP get request before each example
      before { post '/api/v1/sign_in', params: existing_username }

      it 'returns a json response' do
        expect(json).not_to be_empty
      end

      it 'creates a session variable with user id' do
        expect(session[:user_id]).to eq(users.first.id)
        expect(session[:user_id]).not_to eq(users.second.id)
      end

      it 'returns correct user data' do
        expect(json['user']['name']).to eq(users.first.name)
        expect(json['user']['id']).to eq(users.first.id)
        expect(json['user']['id']).not_to eq(users.second.id)
      end

      it 'returns logged_in status as true' do
        expect(json['logged_in']).to be true
        expect(json['logged_in']).not_to be false
      end

      it 'returns json status as \'created\'' do
        expect(json['status']).to eq('created')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response).not_to have_http_status(401)
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the user doesn\'t exist in the database' do
      # make HTTP get request before each example
      before { post '/api/v1/sign_in', params: non_existing_username }

      it 'returns a json response' do
        expect(json).not_to be_empty
        expect(json.size).to be 1
      end

      it 'returns status code 401' do
        expect(json['status']).to eq(401)
      end
    end
  end

  describe 'DELETE /api/v1/sign_out' do
    before { delete '/api/v1/sign_out' }

    it 'returns a json response' do
      expect(json).not_to be_empty
      expect(json.size).to be 2
    end

    it 'resets session variable' do
      expect(session[:user_id]).to be_nil
    end

    it 'returns logged_out status as false' do
      expect(json['logged_out']).to be true
      expect(json['logged_out']).not_to be false
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
      expect(response).not_to have_http_status(401)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
