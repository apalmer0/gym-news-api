class Bulletin < ActiveRecord::Base
  belongs_to :gym, inverse_of: :bulletins
  has_many :climbs, inverse_of: :bulletin, dependent: :destroy
end
