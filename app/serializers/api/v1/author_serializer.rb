class Api::V1::AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio
  has_many :books
end
