# tyne

[![travis-ci](https://secure.travis-ci.org/tyne/tyne.png)](http://travis-ci.org/#!/tyne/tyne) [![Dependency Status](https://gemnasium.com/tyne/tyne.png)](https://gemnasium.com/tyne/tyne) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/tyne/tyne)

## Description

Tyne is a webbased issue tracking application with the following features:
* Github authentication
* Project import from github
* Project management
* Issue tracking

Do you want to check the current status of the project? We have deployed a demo to http://sultry-earth-9895.herokuapp.com

## Installation

### Gem dependencies

Run the following command to install all the dependencies:
```
bundle install
```

### Database configuration

Enter your database details: ```config/database.yml```

Run the following command: ```bundle exec rake db:setup```

### OmniAuth configuration

In order to use OmniAuth via Github you need to set up some environment keys. Add the following to your ```.bash_profile``` or ```.bashrc```.

```bash
export GITHUB_KEY=your_key
export GITHUB_SECRET=your_secret
```

You will need to register a new developer application in order to get those details. Simply go to https://github.com/settings/applications and register a new application with the following details:

```
Name: Tyne (localhost)
URL: http://localhost:3000
Callback URL: http://localhost:3000/auth/github/callback
```

### Start the server

Start your rails server via ```rails s```

## Testing

This gem uses rspec. Simply run ```bundle exec rspec spec``` as usual.

The test suite is using a github user in order to test the OmniAuth integration. Please make sure you have added the following environment variables:

```
export CAPYBARA_USER=username
export CAPYBARA_PASSWORD=password
```

## Contribute

Please read our [contribution-guidelines](https://github.com/tyne/tyne/blob/master/CONTRIBUTING.md).

## Maintainers

* Tobias Haar (http://github.com/Tobscher)
* Michael Lessnau (http://github.com/mlessnau)

## License

MIT License. Copyright 2012 Tobias Haar.
