module ApplicationHelper
  def flash_messages(opt = {})
    flash.each do |type, message|
      concat(
        content_tag(:div, message, class: "alert flash-#{type} fade in") do
          concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
          concat message
        end
      )
    end
  end
end
