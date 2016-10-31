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

### Command Line arguments
The template responds to certain command line arguments passed to the
`rails new` generator.  All of these commands start with `m_` like
`--m_git`.  Most of the arguments are boolean and appear or don't.
However, for arguments like `--m_remote` and `--m_user` a value must be
set like this: `--m_user=Admin`.  The `=` is important.

| Argument      | Type    | Notes                                                                                                                                                         |
|---------------|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **m_git**     | Boolean | When present, sets up a new git repository and commits template output                                                                                        |
| **m_remote**  | String  | Set with `--m_remote=BLAH`, sets the upstream URL for an origin git remote                                                                                    |
| **m_devise**  | Boolean | When present, sets up devise                                                                                                                                  |
| **m_user**    | String  | Set with `--m-user=Admin`, sets the class name used by Devise                                                                                                 |
| **m_heroku**  | Boolean | When present, sets up a new heroku app and pushes the initial build _([Heroku Toolbelt] must be installed and logged in prior to running the template)_     |
| **m_minimal** | Boolean | When present, runs only the basic install and skips all other setup including git, devise, heroku                                                             |
| **m_force**   | Boolean | When present, no interactive questions are asked during installation _(Everything defaults to false, except git unless otherwise passed on the command line)_ |

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

[binstubs]:https://github.com/tpope/heroku-binstubs
[Devise]:https://github.com/plataformatec/devise
[Heroku Toolbelt]:https://devcenter.heroku.com/articles/heroku-command-line
[Matt Brictson's]:https://github.com/mattbrictson
[PostgresQL]:https://www.postgresql.org/
[Rails 5.0.x]:https://github.com/rails/rails
[rails-template]:https://github.com/mattbrictson/rails-template
[Redis]:http://redis.io
