run "bundle install"

generate 'devise:install'

%i(development test).each do |env|
  environment "config.action_mailer.default_url_options = {"\
    "protocol: 'http', host: 'localhost'"\
    "}",
    env: env
end

environment "config.action_mailer.default_url_options = {"\
  "protocol: 'https',"\
  "host: AppEnv.try(:email_host),"\
  "port: AppEnv.try(:email_host_port)"\
  "}",
  env: :production

generate "devise #{@t_options[:user]}"
