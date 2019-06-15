class   UserSerializer < BaseSerializer
  attributes :id, :email, :created_at
  attribute :jwt_token
end
