module ApplicationHelper
  # Based on the gist by suryart: https://gist.github.com/suryart/7418454

  def bootstrap_class_for flash_type
    {
      success: 'alert-success',
      notice:  'alert-info',
      alert:   'alert-warning',
      error:   'alert-danger',
    }[flash_type.to_sym]
  end

  def class_for flash_type
    bootstrap_class_for(flash_type) || flash_type.to_s
  end

  def flash_messages(opt = {})
    flash.each do |type, message|
      concat(
        content_tag(:div, message, class: "alert #{class_for(type)} fade in") do
          concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
          concat message
        end
      )
    end
  end
end
