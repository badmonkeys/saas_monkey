# The Bad Monkeys Rails Template
A custom template and supporting files to generate a new Rails 5 SaaS
application.

## Setup
The template requires that you have rails 5 installed so before using it
make sure you have the new release with:

```
$ gem install rails
```

## Usage
The template can be easily used during the creation of a new Rails 5
application by using the following:

```
$ rails new app_name -m https://raw.githubusercontent.com/badmonkeys/bad_monkey_rails/master/saas_template.rb
```

If you want to customize the template before using it just clone the
repo and modify the desired files.

```
git clone https://github.com/badmonkeys/bad_monkey_rails.git
```

the cloned template can be used with

```
$ rails new app_name -m /local/path/to/cloned/saas_template.rb
```

## New Features!!
#### Heroku App Creation
The template now asks after installation if you'd like to create a new
heroku app for this project.  If you answer "yes"-y (i.e. `y`, `Y`, or
`yes`) it will create a new app using the heroku toolbelt and configure
the free-tier of the NewRelic RPM addon.  It also uses [binstubs](https://github.com/tpope/heroku-binstubs)
so that working with the heroku app has never been easier.  Simply use
`production` when you want to use the heroku toolbelt like so:

```
$ production run console

$ production logs

$ production addons:create ...
```


## Coming Soon
_Currently Accepting Feature Requests, just create a new issue_

