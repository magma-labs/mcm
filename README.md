# Mcm
A small content manager that allows you to build custom pages through selecting components in a GUI. Can be mounted
as an engine into any Rails app.

## Dependencies

Your app needs to have this in order to use this engine:

- Bootstrap 4 (5 is not fully supported yet)
- `active_storage` for image processing.

## Installation
Add the gem to your bundle:
```bash
$ bundle add mcm --github "magma-labs/mcm"
```

Install and run migrations by doing:
```bash
$ bundle exec rails mcm:install:migrations
$ bundle exec rails db:migrate
```

Import the default set of components into your database by running:
```bash
$ bundle exec rails mcm:sync_components
```

## Setup

Create a `config/initializer/mcm.rb` file with the following content:
```ruby
# config/initializer/mcm.rb

Mcm.layout = 'application'
Mcm.admin_layout = 'application'
Mcm.controller_parent = 'ApplicationController'
Mcm.admin_controller_parent = 'ApplicationController'
```

Mount the engine in the root path of your app:
```ruby
# config/routes.rb
Rails.application.routes.draw do
  mount Mcm::Engine, at: "/"
end
```

## Contributing
Help wanted!

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
