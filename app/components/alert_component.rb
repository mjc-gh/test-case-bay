# frozen_string_literal: true

class AlertComponent < ViewComponent::Base
  def initialize(type:)
    case type
    when :alert
      @html_class = 'bg-red-200 text-red-900'
      @svg_icon_html_class = 'text-red-800'
      @svg_icon = 'exclamation_circle.svg'
    when :notice
      @html_class = 'bg-blue-200 text-blue-900'
      @svg_icon_html_class = 'text-blue-800'
      @svg_icon = 'information_circle.svg'
    else
      raise ArgumentError, 'Invalid AlertComponent :type'
    end
  end
end
