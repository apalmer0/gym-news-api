class User < ActiveRecord::Base
  has_one :profile, inverse_of: :user, dependent: :destroy

  include Authentication

end
