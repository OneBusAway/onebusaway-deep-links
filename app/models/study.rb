class Study < ApplicationRecord
  validates :name, presence: true
  normalizes :name, with: lambda(&:strip)

  validates :description, presence: true
  normalizes :description, with: lambda(&:strip)

  belongs_to :region

  # Study Invites

  after_create do
    study_invites.create(name: "#{name} Invitation")
  end

  has_many :study_invites, dependent: :destroy

  # Extra Data

  jsonb_accessor(:extra_data, {})
end
