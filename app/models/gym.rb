class Gym < ActiveRecord::Base
  has_many :climbs, inverse_of: :gym, dependent: :destroy
  has_many :bulletins, inverse_of: :gym, dependent: :destroy
end
