_Inspiration for the recent restructure from [Matt Brictson's][]
[rails-template][] project_

# The Bad Monkeys Rails Template
A custom template and supporting files to generate a new Rails 5 SaaS
application.

## Requirements
This template is designed to work with:

- [Rails 5.0.x][]
- [PostgresQL][]
- [Redis][]

The template requires that you have rails `~> 5.0` so before using it
make sure you have the new release with:

```
$ gem install rails
```


## Installation
To make this template the default template used for all new rails
applications, create (or modify) a `~/.railsrc` file and add:

```
-d postgresql
-m https://raw.githubusercontent.com/badmonkeys/saas_monkey/master/template.rb
```

## Usage
The template can be easily used during the creation of a new Rails 5
application in several ways.

```
$ rails new app_name \
    -d postgresql \
    -m https://raw.githubusercontent.com/badmonkeys/saas_monkey/master/template.rb
```

## Features

### Gemset
_README for the current set of gems in this template and their usage
Coming Soon_

### Devise Setup
The template will ask during the application process if you'd like to
setup [Devise][] for authentication.  The default response to this
question is `no`.  You can enter any response matching `/^y(es)?/i` to
install and configure Devise. The devise class you want to use (Usually
`User`) is also configurable through a question and defaults to `User`

### Heroku App Creation
The template now asks after installation if you'd like to create a new
heroku app for this project.  If you answer "yes"-y (i.e. `y`, `Y`, or
`yes`) it will create a new app using the heroku toolbelt and configure
the free-tier of the NewRelic RPM addon. The name of your new heroku app
will be the `dasherize` version of the name provided to the `rails new`
command. It also uses initializes Heroku [binstubs][]
so that working with the heroku app has never been easier.  Simply use
`production` when you want to use the heroku toolbelt like so:

```
$ production run console

$ production logs

$ production addons:create ...
```


## Customization
Fork It! This is just a quick starting point built from my workflow and
default tools.  Feel free to fork it, clone it, flame it, whatever. Just
make sure to make it your own!

[Devise]:https://github.com/plataformatec/devise
[binstubs]:https://github.com/tpope/heroku-binstubs
[Matt Brictson's]:https://github.com/mattbrictson
[rails-template]:https://github.com/mattbrictson/rails-template
[Rails 5.0.x]:https://github.com/rails/rails
[PostgresQL]:https://www.postgresql.org/
[Redis]:http://redis.io
