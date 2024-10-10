module ApplicationHelper
  def error_message_for(field)
    return unless @warehouse.errors[field].any?

    content_tag(:div, @warehouse.errors.full_messages_for(field).first, class: 'field-error')
  end
end
