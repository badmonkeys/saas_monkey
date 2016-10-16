def heroku_name
  @heroku_name ||= app_name.dasherize
end

after_bundle do
  if !`which heroku`.blank?
    run "heroku create #{heroku_name}"
    run 'heroku plugins:install https://github.com/tpope/heroku-binstubs.git'
    run "heroku binstubs:create #{heroku_name}"
    run 'production addons:create heroku-postgresql:hobby-dev'
    run 'production addons:create newrelic:wayne'
    run 'production buildpacks:set heroku/ruby'
    run 'production buildpacks:add https://github.com/gunpowderlabs/buildpack-ruby-rake-deploy-tasks'
    run 'production config:set DEPLOY_TASKS=db:migrate'
    new_relic_key = `production config:get NEW_RELIC_LICENSE_KEY`
    run "newrelic install --license_key='#{new_relic_key}' '#{heroku_name}'"

    if apply_git?
      run "production git:remote --app #{heroku_name}"

      git add: '-A .'
      git commit: '-m "Sets up heroku integration"'
      git push: 'heroku master'
    end
  else
    fail Rails::Generators::Error, "Heroku toolbelt is not installed."\
      "Install it from https://devcenter.heroku.com/articles/heroku-command-line"
  end
end
