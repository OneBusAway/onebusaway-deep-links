class Survey < ApplicationRecord
  belongs_to :study

  # Extra Data

  jsonb_accessor(:extra_data, {
                   name: :string,

                   show_on_map: :boolean,
                   show_on_stops: :boolean,
                   require_stop_id_in_response: :boolean,
                   visible_stop_list: :string,
                   visible_route_list: :string
                 })

  validates :name, presence: true

  validate :require_stop_id_sensibility

  # Survey Questions

  has_many :questions, -> { order(position: :asc) }, dependent: :destroy

  # Survey Responses

  has_many :survey_responses, dependent: :destroy

  private

  def require_stop_id_sensibility
    if require_stop_id_in_response && !show_on_stops && !errors.add(:require_stop_id_in_response, 'is only valid if Show on Stops is true')
      return
    end

    return unless require_stop_id_in_response && show_on_map

    errors.add(:require_stop_id_in_response, 'is only valid if Show on Map is false')
    
  end
end
