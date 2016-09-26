$raise_on_missing_config = true

class AppEnv

  def self.raise_on_missing!(to_raise = true)
    $raise_on_missing_config = to_raise
  end

  def self.method_missing(method, *_args, &block)
    if method.match(/(.*)\?$/)
      fetch_bool($1, &block)
    else
      fetch(method, &block)
    end
  end

  def self.try(key)
    if include? key
      ENV.fetch(key.to_s.upcase)
    else
      nil
    end
  end

  def self.include?(key)
    ENV.include?(key.to_s.upcase)
  end

  def self.fetch(key, &block)
    ENV.fetch(key.to_s.upcase, &block)
  rescue KeyError
    if $raise_on_missing_config
      raise(KeyError, "#{key} missing from config", caller)
    end
  end

  def self.fetch_bool(key, &block)
    b = self.fetch(key, &block)
    return true if(b =~ (/(true|t|yes|y|1)$/i))
    return false if(b.blank? || b =~ (/(false|f|no|n|0)$/i))
    raise ArgumentError.new("Cannot make boolean from this: #{b}")
  end
end
