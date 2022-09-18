module ApplicationHelper
  def model_errors(model)
    tag.code(class: 'whitespace-pre text-sm text-red-400') { model.errors.full_messages.join("\n") } if model.errors.any?
  end

  def position_from_index(index, total)
    return :single if total == 1
    return :first if index.zero?

    index == total - 1 ? :last : :middle
  end
end
