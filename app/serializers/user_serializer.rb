class UserSerializer < ActiveModel::Serializer
  attributes :email, :username, :gravatar_url

end
