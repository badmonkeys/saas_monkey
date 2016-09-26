environment 'config.after_initialize do
    Bullet.tap do |b|
      b.enable        = true
      b.alert         = true
      b.bullet_logger = true
      b.console       = true
      b.rails_logger  = true
    end
  end',
  env: :development

environment 'config.after_initialize do
    Bullet.tap do |b|
      b.enable        = true
      b.bullet_logger = true
      b.raise         = true
    end
  end',
  env: :test

