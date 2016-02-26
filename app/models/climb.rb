class Climb < ActiveRecord::Base
  belongs_to :gym, inverse_of: :climbs

  validates :gym, presence: true
end
