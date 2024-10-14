class Forms::DateTimeFieldComponent < Forms::TextFieldComponent
  def initialize(form:, method:, value:, **options)
    options[:type] ||= 'datetime-local'

    formatted_value = value&.strftime('%Y-%m-%dT%H:%M')

    super(form:, method:, value: formatted_value, **options)
  end
end
