class Survey < ApplicationRecord
  belongs_to :study

  # Extra Data

  jsonb_accessor(:extra_data, {
                   name: :string,

                   show_on_map: :boolean,
                   show_on_stops: :boolean,
                   visible_stop_list: :string,
                   visible_route_list: :string
                 })

  validates :name, presence: true

  # Survey Questions

  has_many :questions, -> { order(position: :asc) }, dependent: :destroy

  # Survey Responses

  has_many :survey_responses, dependent: :destroy
end
