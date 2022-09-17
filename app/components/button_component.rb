# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  HTML_COLOR_CLASSES = {
    primary: 'border-transparent bg-teal-600 text-white hover:bg-teal-700 focus:ring-teal-500',
    danger: 'border-transparent bg-red-600 text-white hover:bg-red-700 focus:ring-red-500',
    clear: 'border-teal-400 text-teal-500 hover:text-teal-600 hover:border-teal-600',
  }

  HTML_SIZE_CLASSES = {
    xsmall: 'px-2.5 py-1.5 text-xs',
    small: 'px-3 py-2 text-sm',
    medium: 'px-4 py-2 text-sm',
    large: 'px-4 py-2 text-base',
    xlarge: 'px-6 py-3 text-base'
  }

  def initialize(type: 'button', color: :primary, size: :medium, **kwargs)
    @type = type
    @kwargs = kwargs

    @html_class = 'inline-flex items-center rounded border shadow-sm font-medium '\
      'focus:outline-none focus:ring-2 focus:ring-offset-2 '\
      "#{HTML_COLOR_CLASSES[color]} #{HTML_SIZE_CLASSES[size]}"
  end

  def call
    tag.button type: @type, class: @html_class, **@kwargs do
      content
    end
  end
end
