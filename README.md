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

## Coming Soon
_Currently Accepting Feature Requests, just create a new issue_

* Heroku App Creation
  - question based during the template application process
  - app creation on heroku
  - remote setting in local git
  - [binstubs](https://github.com/tpope/heroku-binstubs)
* Bugsnag Integration
  - sets up the app with basic bugsnag setup
  - properly configures addon on heroku (free-tier)
* NewRelic Integration
  - sets up the app with basic new relic setup
  - properly configures addon on heroku (free-tier)

