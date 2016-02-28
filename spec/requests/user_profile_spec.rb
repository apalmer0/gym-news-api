require 'rails_helper'

RSpec.describe 'User Profile API' do
  def user_params
    {
      email: 'alie@example.com',
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

  def user_profile
    user.profile
  end

  before(:all) do
    User.create!(user_params)
    # user.profile << Comment.create!(profile_params)
    # this allows for the creation of a profile without being associated with an user
    # and then associates that unassociated profile with an user.

    # we actually want to create a profile that's associated with an user initially,
    # using 'build'
    user.create_profile(profile_params)


    # # Create an unassociated profile to prove scoping
    # Comment.create!(profile_params)
  end

  after(:all) do
    User.destroy_all

  end

  describe 'GET /users/:id/profiles/:id' do
    it 'returns the profile of a given user' do
      get "/users/#{user.id}/profiles/#{user_profile.id}"

      expect(response).to be_success

      parsed_response = JSON.parse(response.body)
      # binding.pry
      expect(
        parsed_response['first_name']
      ).to eq(user_profile.first_name)
    end
  end

  context 'when authenticated' do
    def headers
      {
        'HTTP_AUTHORIZATION' => "Token token=#{user.token}"
      }
    end

    describe 'POST /users/:id/profiles' do
      it 'creates a profile for a given user' do
        post "/users/#{user.id}/profiles", { profile: profile_params }, headers
            #  profile: profile_params,
            #  format: :json,
            #  headers

        expect(response).to be_success

        user_profile_response = JSON.parse(response.body)

        expect(user_profile_response['id']).not_to be_nil
        expect(user_profile_response['user_id']).not_to be_nil
        expect(
          user_profile_response['first_name']
        ).to eq(profile_params[:first_name])
      end
    end

    describe 'PATCH /users/:id/profiles/:id' do
      def profile_diff
        { first_name: 'Updated Profilefirst_name' }
      end

      it 'updates a profile' do
        patch "/users/#{user.id}/profiles/#{user_profile.id}", { profile: profile_diff }, headers
        #  yo. note the arguments and the hash

        expect(response).to be_success

        profile_response = JSON.parse(response.body)
        expect(profile_response['id']).to eq(user_profile.id)
        expect(profile_response['first_name']).to eq(profile_diff[:first_name])
      end
    end


    describe 'DELETE /users/:id/profiles/:id' do
      it 'deletes a profile' do
        delete "/users/#{user.id}/profiles/#{user_profile.id}", nil, headers
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

    describe 'POST /users/:id/profiles' do
      it 'is not successful' do
        post "/users/#{user.id}/profiles", nil, headers
        # no point in actually passing data in that second arg, bc if this test is to pass, it'll
        # never get to the point where it actually needs data.

        expect(response).not_to be_success
      end
    end

    describe 'PATCH /users/:id/profiles/:id' do
      it 'is not successful' do
        patch "/users/#{user.id}/profiles/#{user_profile.id}", nil, headers

        expect(response).not_to be_success
      end
    end

    describe 'DELETE /users/:id/profiles/:id' do
      it 'is not successful' do
        delete "/users/#{user.id}/profiles/#{user_profile.id}", nil, headers

        expect(response).not_to be_success
      end
    end
  end
end
