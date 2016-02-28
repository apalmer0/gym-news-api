class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :user, presence: true
end
