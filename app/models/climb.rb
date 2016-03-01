class Climb < ActiveRecord::Base
  belongs_to :gym, inverse_of: :climbs
  has_many :fans, through: :favorites, source: :user
  has_many :favorites

  validates :gym, presence: true
end
