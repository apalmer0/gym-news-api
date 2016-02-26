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
    Climb.create!(climb_params)
    Gym.create!(gym_params)
  end

  after(:all) do
    Climb.delete_all
    User.delete_all
    Gym.delete_all
  end

  describe 'GET /climbs' do
    it 'lists all climbs' do
      get '/climbs'

      expect(response).to be_success

      climbs_response = JSON.parse(response.body)
      expect(climbs_response.length).to eq(climbs.count)
      expect(climbs_response.first['color']).to eq(climb.color)
    end
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

  context 'when authenticated' do
    # 'context' is the exact same thing as 'describe' but tells the developer
    # that you've changed state of the app
    def headers
      {
        'HTTP_AUTHORIZATION' => "Token token=#{user.token}"
      }
    end

    describe 'POST /climbs' do
      it 'creates a climb' do
        post '/climbs', climb_params, headers
        # post takes arguments. the first is the climb (the data)
        # the second hash argument to post is a collection of headers

        # whenever you see two hash arguments, you HAVE to put the first argument
        # within curly braces. if you don't, the error is super shitty and not helpful.
        # seems like the error is "unexpected keyword end"... which doesn't help
        # for needing to add curly braces here.

        # this is really just like curl

        expect(response).to be_success

        climb_response = JSON.parse(response.body)
        expect(climb_response['id']).not_to be_nil
        expect(climb_response['color']).to eq(climb_params[:color])
      end
    end

    describe 'PATCH /climbs/:id' do
      def climb_diff
        { color: 'Green' }
      end

      it 'updates an climb' do
        patch "/climbs/#{climb.id}", climb_diff, headers
        #  yo. note the arguments and the hash

        expect(response).to be_success

        climb_response = JSON.parse(response.body)
        expect(climb_response['id']).to eq(climb.id)
        expect(climb_response['color']).to eq(climb_diff[:color])
      end
    end

    describe 'DELETE /climbs/:id' do
      it 'deletes an climb' do
        delete "/climbs/#{climb.id}", nil, headers
        # yo. these arguments are positional (you can't switch nil and headers)

        expect(response).to be_success
        expect(response.body).to be_empty
      end
    end
  end

  context 'when not authenticated' do
    def headers
      {
        'HTTP_AUTHORIZATION' => nil
        # this isn't necessary, but it's WAY more explicit. this is pretty helpful.
      }
    end

    describe 'POST /climbs' do
      it 'is not successful' do
        post '/climbs', nil, headers
        # no point in actually passing data in that second arg, bc if this test is to pass, it'll
        # never get to the point where it actually needs data.

        expect(response).not_to be_success
      end
    end

    describe 'PATCH /climbs/:id' do
      it 'is not successful' do
        patch "/climbs/#{climb.id}", nil, headers

        expect(response).not_to be_success
      end
    end

    describe 'DELETE /climbs/:id' do
      it 'is not successful' do
        delete "/climbs/#{climb.id}", nil, headers

        expect(response).not_to be_success
      end
    end
  end
end
