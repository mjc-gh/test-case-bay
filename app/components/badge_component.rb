# frozen_string_literal: true

class BadgeComponent < ViewComponent::Base
  HTML_COLOR_CLASSES = {
    default: 'bg-gray-100 bg-stone-900',
    primary: 'bg-teal-700 text-teal-100',
    warning: 'bg-red-700 text-red-100'
  }

  HTML_SIZE_CLASSES = {
    small: 'px-2.5 py-0.5 text-xs ',
    medium: 'px-3 py-0.5 text-sm ',
  }

  def initialize(color: :primary, size: :medium, **kwargs)
    @kwargs = kwargs

    @html_class = 'inline-flex items-center rounded-full font-medium '\
      "#{HTML_COLOR_CLASSES[color]} #{HTML_SIZE_CLASSES[size]}"
  end

  def call
    tag.span class: @html_class, **@kwargs do
      content
    end
  end
end
