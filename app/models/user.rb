class User < ActiveRecord::Base
  has_many :climbs, through: :favorites
  has_many :favorites, inverse_of: :user, dependent: :destroy

  validates_presence_of :first_name, :last_name

  include Authentication

end
