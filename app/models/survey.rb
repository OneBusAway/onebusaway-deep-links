class Survey < ApplicationRecord
  include Filterable

  belongs_to :study

  scope :filter_currently_active, lambda {
    where('? BETWEEN start_date AND end_date OR (start_date IS NULL OR end_date IS NULL)', Time.now.utc)
  }

  # Extra Data

  jsonb_accessor(:extra_data, {
                   name: :string,

                   show_on_map: [:boolean, { default: false }],
                   show_on_stops: [:boolean, { default: false }],
                   require_stop_id_in_response: [:boolean, { default: false }],
                   visible_stop_list: :string,
                   visible_route_list: :string
                 })

  validates :name, presence: true

  validate :require_stop_id_sensibility

  validate :validate_date_presence
  validate :validate_date_order

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

  def validate_date_presence
    return unless start_date.present? || end_date.present?

    if start_date.present? && end_date.blank?
      errors.add(:end_date, "must be present if start_date is provided")
    elsif end_date.present? && start_date.blank?
      errors.add(:start_date, "must be present if end_date is provided")
    end
  end

  def validate_date_order
    return unless start_date.present? && end_date.present? && end_date <= start_date

    errors.add(:end_date, "must be after the start date")
  end
end
