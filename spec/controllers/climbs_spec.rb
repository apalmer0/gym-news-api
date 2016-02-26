require 'rails_helper'

RSpec.describe ClimbsController do
  def climb_params
    {
      color: 'Blue',
      grade: '12',
      modifier: '+'
    }
  end

  def climb
    Climb.first
  end

  def user_params
    {
      email: 'alice@example.com',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    }
  end

  def user
    User.first
  end

  def gym_params
    {
      name: 'Fake Gym',
      city: 'Boston',
      state: 'Massachusetts'
    }
  end

  def gyms
    Gym.all
  end

  def gym
    Gym.first
  end

  before(:all) do
    User.create!(user_params)
    Gym.create!(gym_params)
    gym.climbs.create!(climb_params)
  end

  after(:all) do
    Climb.delete_all
    Gym.delete_all
    User.delete_all
  end

  describe 'GET index' do
    before(:each) { get :index, gym_id: gym.id }
    it 'is succesful' do
      expect(response.status).to eq(200)
    end

    it 'renders a JSON response' do
      climbs_collection = JSON.parse(response.body)
      expect(climbs_collection).not_to be_nil
    end
  end

  describe 'GET show' do
    it 'is successful' do
      get :show, id: climb.id, gym_id: gym.id

      expect(response.status).to eq(200)
    end

    it 'renders a JSON response' do
      get :show, id: climb.id, gym_id: gym.id

      climb_response = JSON.parse(response.body)
      expect(climb_response).not_to be_nil
    end
  end

  context 'when authenticated' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = "Token token=#{user.token}"
    end

    describe 'POST create' do
      before(:each) do
        post :create, climb: climb_params, format: :json, gym_id: gym.id
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'renders a JSON response' do
        climb_response = JSON.parse(response.body)
        expect(climb_response).not_to be_nil
      end
    end

    describe 'PATCH update' do
      def climb_diff
        { color: 'Green' }
      end

      before(:each) do
        patch :update, id: climb.id, climb: climb_diff, format: :json, gym_id: gym.id
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'renders a JSON response' do
        climb_response = JSON.parse(response.body)
        expect(climb_response).not_to be_nil
      end
    end

    describe 'DELETE destroy' do
      it 'is successful and returns an empty response' do
        delete :destroy, id: climb.id, format: :json, gym_id: gym.id

        expect(response).to be_successful
        expect(response.body).to be_empty
      end
    end
  end

  context 'when not authenticated' do
    before(:each) do
      request.env['HTTP_AUTHORIZATION'] = nil
    end

    describe 'POST create' do
      it 'is not successful' do
        post :create, climb: climb_params, gym_id: gym.id
        expect(response).not_to be_successful
      end
    end

    describe 'PATCH update' do
      it 'is not successful' do
        patch :update, id: climb.id, gym_id: gym.id
        expect(response).not_to be_successful
      end
    end

    describe 'DELETE destroy' do
      it 'is not successful' do
        delete :destroy, id: climb.id, gym_id: gym.id
        expect(response).not_to be_successful
      end
    end
  end
end
