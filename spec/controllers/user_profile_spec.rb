require 'rails_helper'

RSpec.describe ProfilesController do
  def user_params
    {
      email: 'badee@example.com',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    }
  end

  def profile_params
    {
      first_name: 'Example',
      last_name: 'User'
    }
  end

  def user
    User.first
  end

  before(:all) do
    User.create!(user_params)
    user.create_profile(profile_params)
  end

  after(:all) do
    User.destroy_all
  end

  describe 'GET users#index' do
    before(:each) do
      get :index, user_id: user.id
    end

    it 'is succesful' do
      expect(response.status).to eq(200)
    end

    it 'renders a JSON response with embedded profiles' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.first).not_to be_nil
    end
  end

  describe 'GET show' do
    it 'is successful' do
      get :show, user_id: user.id, id: user.profile.id

      expect(response.status).to eq(200)
    end

    it 'renders a JSON response' do
      get :show, user_id: user.id, id: user.profile.id

      profile_response = JSON.parse(response.body)
      expect(profile_response).not_to be_nil
    end
  end

  describe 'POST create' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Token token=#{user.token}"
      post :create, user_id: user.id, profile: profile_params, format: :json
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders a JSON response' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).not_to be_nil
    end
  end
end
