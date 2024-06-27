class StudyInvite < ApplicationRecord
  belongs_to :study

  # Extra Data

  jsonb_accessor(:extra_data, {
    name: :string,
  })

  validates :name, presence: true
end
