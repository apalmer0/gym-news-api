require 'rails_helper'

RSpec.describe 'Gyms API' do
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
      email: 'alice@example.com',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    }
  end

  def user
    User.first
  end

  before(:all) do
    Gym.create!(gym_params)
    User.create!(user_params)
  end

  after(:all) do
    Gym.delete_all
    User.delete_all
  end

  describe 'GET /gyms' do
    it 'lists all gyms' do
      get '/gyms'

      expect(response).to be_success

      gyms_response = JSON.parse(response.body)
      expect(gyms_response.length).to eq(gyms.count)
      expect(gyms_response.first['name']).to eq(gym.name)
    end
  end

  describe 'GET /gyms/:id' do
    it 'shows one gym' do
      get "/gyms/#{gym.id}"

      expect(response).to be_success

      gym_response = JSON.parse(response.body)
      expect(gym_response['id']).to eq(gym.id)
      expect(gym_response['name']).to eq(gym.name)
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

    describe 'POST /gyms' do
      it 'creates a gym' do
        post '/gyms', { gym: gym_params }, headers
        # post takes arguments. the first is the gym (the data)
        # the second hash argument to post is a collection of headers

        # whenever you see two hash arguments, you HAVE to put the first argument
        # within curly braces. if you don't, the error is super shitty and not helpful.
        # seems like the error is "unexpected keyword end"... which doesn't help
        # for needing to add curly braces here.

        # this is really just like curl

        expect(response).to be_success

        gym_response = JSON.parse(response.body)
        expect(gym_response['id']).not_to be_nil
        expect(gym_response['name']).to eq(gym_params[:name])
      end
    end

    describe 'PATCH /gyms/:id' do
      def gym_diff
        { name: 'Updated Gymname' }
      end

      it 'updates an gym' do
        patch "/gyms/#{gym.id}", { gym: gym_diff }, headers
        #  yo. note the arguments and the hash

        expect(response).to be_success

        gym_response = JSON.parse(response.body)
        expect(gym_response['id']).to eq(gym.id)
        expect(gym_response['name']).to eq(gym_diff[:name])
      end
    end

    describe 'DELETE /gyms/:id' do
      it 'deletes a gym' do
        delete "/gyms/#{gym.id}", nil, headers
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

    describe 'POST /gyms' do
      it 'is not successful' do
        post '/gyms', nil, headers
        # no point in actually passing data in that second arg, bc if this test is to pass, it'll
        # never get to the point where it actually needs data.

        expect(response).not_to be_success
      end
    end

    describe 'PATCH /gyms/:id' do
      it 'is not successful' do
        patch "/gyms/#{gym.id}", nil, headers

        expect(response).not_to be_success
      end
    end

    describe 'DELETE /gyms/:id' do
      it 'is not successful' do
        delete "/gyms/#{gym.id}", nil, headers

        expect(response).not_to be_success
      end
    end
  end
end
