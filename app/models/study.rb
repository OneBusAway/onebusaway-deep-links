class Study < ApplicationRecord
  validates :name, presence: true
  normalizes :name, with: lambda(&:strip)

  validates :description, presence: true
  normalizes :description, with: lambda(&:strip)

  belongs_to :region
end
