class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 30 }
  validates :bio, presence: true, length: { minimum: 1, maximum: 100 }

  before_save :capitalize_attributes

  private

  def capitalize_attributes
    attributes_to_capitalize.each do |attr|
      self[attr] = self[attr].capitalize if self[attr].present?
    end
  end

  def attributes_to_capitalize
    %w[name]
  end
end
