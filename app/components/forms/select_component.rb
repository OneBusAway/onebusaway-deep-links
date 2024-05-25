# frozen_string_literal: true

# rubocop:disable Layout/LineLength

class Forms::SelectComponent < ViewComponent::Base
  def initialize(form:, method:, collection:, options: {}, html_options: {})
    @form = form
    @method = method
    @collection = collection
    @options = options
    @html_options = html_options

    css = @html_options[:class]
    @html_options[:class]= class_names(css, DEFAULT_CSS)
  end

  DEFAULT_CSS = "mt-0.5 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-brand sm:text-sm sm:leading-6"
end

# rubocop:enable Layout/LineLength
