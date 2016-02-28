require 'rails_helper'

RSpec.describe 'routes for profiles' do
  it 'routes GET /users/:id/profiles to the profiles#index action' do
    expect(get('/users/1/profiles')).to route_to(
      controller: 'profiles',
      action: 'index',
      user_id: '1'
    )
  end

  it 'routes POST /users/:id/profiles to the profiles#create action' do
    expect(post('/users/1/profiles')).to route_to(
      controller: 'profiles',
      action: 'create',
      user_id: '1'
    )
  end

  it 'routes GET /users/:id/profiles/:id to the profiles#show action' do
    expect(get('/users/1/profiles/1')).to route_to(
      controller: 'profiles',
      action: 'show',
      user_id: '1',
      id: '1'
    )
  end

  it 'routes PATCH /users/:id/profiles/:id to the profiles#update action' do
    expect(patch('/users/1/profiles/1')).to route_to(
      controller: 'profiles',
      action: 'update',
      user_id: '1',
      id: '1'
    )
  end

  it 'routes DELETE /users/:id/profiles/:id to the profiles#destroy action' do
    expect(delete('/users/1/profiles/1')).to route_to(
      controller: 'profiles',
      action: 'destroy',
      user_id: '1',
      id: '1'
    )
  end
end
