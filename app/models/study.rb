class Study < ApplicationRecord
  validates :name, presence: true
  normalizes :name, with: lambda(&:strip)

  validates :description, presence: true
  normalizes :description, with: lambda(&:strip)

  belongs_to :region

  # Study Invites

  after_create do
    surveys.create(name: "#{name} Survey")
  end

  has_many :surveys, dependent: :destroy

  # Extra Data

  jsonb_accessor(:extra_data, {})
end
