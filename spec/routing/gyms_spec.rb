require 'rails_helper'

RSpec.describe 'routes for gyms' do
  it 'routes GET /gyms to the gyms#index action' do
    expect(get('/gyms')).to route_to('gyms#index')
  end

  it 'routes GET /gyms/:id to the gyms#show action' do
    expect(get('/gyms/1')).to route_to(
      controller: 'gyms',
      action: 'show',
      id: '1'
    )
  end

  it 'routes POST /gyms to the gyms#create action' do
    expect(post('/gyms')).to route_to('gyms#create')
  end

  it 'routes PATCH /gyms/:id to the gyms#update action' do
    expect(patch('/gyms/1')).to route_to(
      controller: 'gyms',
      action: 'update',
      id: '1'
    )
  end

  it 'routes DELETE /gyms/:id to the gyms#destroy action' do
    expect(delete('/gyms/1')).to route_to(
      controller: 'gyms',
      action: 'destroy',
      id: '1'
    )
  end
end
