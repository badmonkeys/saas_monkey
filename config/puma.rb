workers Integer(ENV['WEB_WORKERS']     || 1)
threads Integer(ENV['WEB_MIN_THREADS'] || 1),
        Integer(ENV['WEB_MAX_THREADS'] || 16)

environment ENV['RACK_ENV'] || 'development'
port        ENV['PORT'] || 3000

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
