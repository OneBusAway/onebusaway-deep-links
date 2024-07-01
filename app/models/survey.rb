class Survey < ApplicationRecord
  belongs_to :study

  # Extra Data

  jsonb_accessor(:extra_data, {
                   name: :string
                 })

  validates :name, presence: true

  # Survey Questions

  has_many :questions, dependent: :destroy
end
