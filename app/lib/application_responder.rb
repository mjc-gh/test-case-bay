class ApplicationResponder < ActionController::Responder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder

  # When there are errors, always render with the possibility of a turbo_stream
  # format template
  #
  # If there is an explicit :render supplied, render the template with a :success status
  #
  # Otherwise, default to Responder navigation_behavior
  def to_turbo_stream
    if has_errors?
      controller.render (default_action || options[:action]), status: :unprocessable_entity

    elsif options.key?(:render)
      controller.render rendering_options

    else
      navigation_behavior nil
    end
  end
end
