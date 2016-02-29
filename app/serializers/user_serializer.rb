#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name # , :can_edit

  # def can_edit
  #   # defaults to current user which may be nil
  #   scope ? scope == object : false
  # end
end
