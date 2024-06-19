class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :author_id
  belongs_to :author
end
