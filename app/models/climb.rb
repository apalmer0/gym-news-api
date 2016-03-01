class Climb < ActiveRecord::Base
  belongs_to :gym, inverse_of: :climbs
  has_many :fans, through: :favorites, source: :user
  has_many :favorites, inverse_of: :climb, dependent: :destroy

  validates :gym, presence: true
end
