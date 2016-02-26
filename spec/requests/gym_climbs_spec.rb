require 'rails_helper'

RSpec.describe 'Gym Climbs API' do
  def gym_params
    {
      name: 'Fake Gym',
      city: 'Boston',
      state: 'Massachusetts'
    }
  end

  def climb_params
    {
      color: 'Blue',
      grade: '12',
      modifier: '+'
    }
  end

  def gym
    Gym.first
  end

  def gym_climbs
    gym.climbs
  end

  def gym_first_climb
    gym_climbs.first
  end

  def user_params
    {
      email: 'aliec@example.com',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    }
  end

  def user
    User.first
  end

  before(:all) do
    User.create!(user_params)
    Gym.create!(gym_params)
    # gym.climbs << Comment.create!(climb_params)
    # this allows for the creation of a climb without being associated with an gym
    # and then associates that unassociated climb with an gym.

    # we actually want to create a climb that's associated with an gym initially,
    # using 'build'
    gym.climbs.create!(climb_params)


    # # Create an unassociated climb to prove scoping
    # Comment.create!(climb_params)
  end

  after(:all) do
    Gym.destroy_all
  end

  describe 'GET /gyms/:id/climbs' do
    it 'lists all climbs in a given gym' do
      get "/gyms/#{gym.id}/climbs"

      expect(response).to be_success

      parsed_response = JSON.parse(response.body)
      expect(parsed_response.length).to eq(gym_climbs.count)
      expect(
        parsed_response.first['color']
      ).to eq(gym_first_climb.color)
    end
  end

  context 'when authenticated' do
    def headers
      {
        'HTTP_AUTHORIZATION' => "Token token=#{user.token}"
      }
    end

    describe 'POST /gyms/:id/climbs' do
      it 'creates a climb in a given gym' do
        post "/gyms/#{gym.id}/climbs", { climb: climb_params }, headers
            #  climb: climb_params,
            #  format: :json,
            #  headers

        expect(response).to be_success

        gym_climb_response = JSON.parse(response.body)

        expect(gym_climb_response['id']).not_to be_nil
        expect(gym_climb_response['gym_id']).not_to be_nil
        expect(
          gym_climb_response['color']
        ).to eq(climb_params[:color])
      end
    end
  end
end
