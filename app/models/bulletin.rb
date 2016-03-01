class Bulletin < ActiveRecord::Base
  belongs_to :gym, inverse_of: :bulletins
end
