class User < ActiveRecord::Base
  has_many :climbs, through: :favorites
  has_many :favorites, inverse_of: :user, dependent: :destroy

  include Authentication

end
