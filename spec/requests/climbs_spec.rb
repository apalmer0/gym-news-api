require 'rails_helper'

RSpec.describe 'Climbs API' do
  def climb_params
    {
      color: 'Blue',
      grade: '12',
      modifier: '+'
    }
  end

  def climbs
    Climb.all
  end

  def climb
    Climb.first
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

  def user_params
    {
      email: 'example@example.com',
      password: 'password'
    }
  end

  def user
    User.first
  end

  before(:all) do
    User.create!(user_params)
    Gym.create!(gym_params)
    gym.climbs.create!(climb_params)
  end

  after(:all) do
    User.delete_all
    Climb.delete_all
    Gym.delete_all
  end

  describe 'GET /climbs/:id' do
    it 'shows one climb' do
      get "/climbs/#{climb.id}"

      expect(response).to be_success

      climb_response = JSON.parse(response.body)
      expect(climb_response['id']).to eq(climb.id)
      expect(climb_response['color']).to eq(climb.color)
    end
  end

  describe 'PATCH /climbs/:id' do

    # i added this
    def headers
      {
        'HTTP_AUTHORIZATION' => "Token token=#{user.token}"
      }
    end

    def climb_diff
      { color: 'Green' }
    end

    it 'updates a climb' do
      patch "/climbs/#{climb.id}", { climb: climb_diff }, headers

      #  format: :json
      # i replaced format: :json with 'headers' and that caused this test to pass

      expect(response).to be_success

      climb_response = JSON.parse(response.body)
      expect(climb_response['id']).to eq(climb.id)
      expect(climb_response['color']).to eq(climb_diff[:color])
    end
  end

  describe 'DELETE /climbs/:id' do

    # i added this
    def headers
      {
        'HTTP_AUTHORIZATION' => "Token token=#{user.token}"
      }
    end

    it 'deletes a climb' do
      delete "/climbs/#{climb.id}",
             { climb: climb.id },
             headers
            #  comment: { id: comment.id },
            #  format: :json
            # i replaced the comment format and format: :json with 'headers'
            # and that caused this test to pass

      expect(response).to be_success
      expect(response.body).to be_empty
    end
  end
end
