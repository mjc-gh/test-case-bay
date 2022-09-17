# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  HTML_COLOR_CLASSES = {
    primary: 'bg-teal-600 text-white hover:bg-teal-700 focus:ring-teal-500'
  }

  HTML_SIZE_CLASSES = {
    xsmall: 'px-2.5 py-1.5 text-xs',
    small: 'px-3 py-2 text-sm',
    medium: 'px-4 py-2 text-sm',
    large: 'px-4 py-2 text-base',
    xlarge: 'px-6 py-3 text-base'
  }

  def initialize(type: 'button', color: :primary)
    @type = type

    @html_class = 'inline-flex items-center rounded border border-transparent shadow-sm font-medium '\
      'focus:outline-none focus:ring-2 focus:ring-offset-2 '\
      "#{HTML_COLOR_CLASSES[color]} #{HTML_SIZE_CLASSES[size]}"
  end

  def call
    tag.button type: @type, class: @html_class
  end
end
