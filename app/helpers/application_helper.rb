module ApplicationHelper
  def model_errors(model)
    tag.code(class: 'whitespace-pre text-sm text-red-400') { model.errors.full_messages.join("\n") } if model.errors.any?
  end
end
