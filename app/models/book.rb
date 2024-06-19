class Book < ApplicationRecord
  belongs_to :author

  validates :title, presence: true, length: { minimum: 1, maximum: 30 }
  validates :description, presence: true, length: { minimum: 20, maximum: 100 }
end
