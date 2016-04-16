#
class UserLoginSerializer < ActiveModel::Serializer
  attributes :id, :email, :token, :first_name, :last_name
end
