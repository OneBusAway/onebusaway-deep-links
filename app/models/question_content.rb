class QuestionContent
  include StoreModel::Model

  attribute :type, :string
  attribute :label_text, :string

  # Radio and Checkbox
  attribute :options, array: true, default: []

  # External Surveys
  attribute :survey_provider, :string
  attribute :url, :string
  attribute :sdk_configuration_values, :string
  attribute :embedded_data_fields, array: true, default: []

  def prune
    options.reject!(&:blank?)
    embedded_data_fields.reject!(&:blank?)
  end

  def has_content?
    case type
    when 'label'
      label_text.present?
    when 'checkbox', 'radio'
      label_text.present? || options.any?
    when 'external_survey'
      label_text.present? || url.present? || sdk_configuration_values.any? || embedded_data_fields.any?
    else # text # rubocop:disable Lint/DuplicateBranch
      label_text.present? || options.any?
    end
  end

  def stringify_keys
    to_h.stringify_keys
  end

  def to_h
    case type
    when 'label'
      { type:, label_text: }
    when 'checkbox', 'radio'
      { type:, label_text:, options: }
    when 'external_survey'
      { type:,
        label_text:,
        url:,
        sdk_configuration_values:,
        embedded_data_fields:,
        survey_provider: }
    else # text # rubocop:disable Lint/DuplicateBranch
      { type:, label_text: }
    end
  end

  def as_json(options = {})
    to_h.as_json(options)
  end

  def to_json(*_args)
    hash = to_h

    if type == 'external_survey'
      hash['sdk_configuration_values'] = begin
        JSON.parse(hash['sdk_configuration_values'])
      rescue StandardError
        nil
      end
    end

    hash.to_json
  end
end