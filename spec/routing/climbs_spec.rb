require 'rails_helper'

RSpec.describe 'routes for climbs' do
  it 'routes GET /climbs/:id to the climbs#show action' do
    expect(get('/climbs/1')).to route_to(
      controller: 'climbs',
      action: 'show',
      id: '1'
    )
  end

  it 'routes PATCH /climbs/:id to the climbs#update action' do
    expect(patch('/climbs/1')).to route_to(
      controller: 'climbs',
      action: 'update',
      id: '1'
    )
  end

  it 'routes DELETE /climbs/:id to the climbs#destroy action' do
    expect(delete('/climbs/1')).to route_to(
      controller: 'climbs',
      action: 'destroy',
      id: '1'
    )
  end
end
