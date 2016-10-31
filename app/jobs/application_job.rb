class ApplicationJob < ActiveJob::Base
  def self.call(*args)
    perform_later(*args)
  end
  singleton_class.send(:alias_method, :[], :call)
end

