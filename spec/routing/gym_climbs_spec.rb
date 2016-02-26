require 'rails_helper'

RSpec.describe 'routes for gym climbs' do
  it 'routes GET /gyms/:id/climbs to the climbs#index action' do
    expect(get('/gyms/1/climbs')).to route_to(
      controller: 'climbs',
      action: 'index',
      gym_id: '1'
    )
  end

  it 'routes POST /gyms/:id/climbs to the climbs#create action' do
    expect(post('/gyms/1/climbs')).to route_to(
      controller: 'climbs',
      action: 'create',
      gym_id: '1'
    )
  end
end
