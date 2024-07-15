class Survey < ApplicationRecord
  belongs_to :study

  # Extra Data

  jsonb_accessor(:extra_data, {
                   name: :string
                 })

  validates :name, presence: true

  # Survey Questions

  has_many :questions, -> { order(position: :asc) }, dependent: :destroy

  # Survey Responses

  has_many :survey_responses, dependent: :destroy
end
