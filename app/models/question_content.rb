class QuestionContent
  include StoreModel::Model

  attribute :type, :string
  attribute :label_text, :string
  attribute :options, array: true, default: []

  def prune
    options.reject!(&:blank?)
  end

  def has_content?
    label_text.present? || options.any?
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
    else # text # rubocop:disable Lint/DuplicateBranch
      { type:, label_text: }
    end
  end

  def as_json(options = {})
    to_h.as_json(options)
  end

  def to_json(*_args)
    to_h.to_json
  end
end