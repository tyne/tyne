# tyne [![travis-ci](https://secure.travis-ci.org/tyne/tyne.png)](http://travis-ci.org/#!/tyne/tyne)

## Description

Tyne is a webbased issue tracking application with the following features:
* Github authentication
* Project import from github
* Project management
* Issue tracking

Do you want to check the current status of the project? We have deployed a demo to http://sultry-earth-9895.herokuapp.com

## Installation

Run the following command to install all the dependencies:
```
bundle install
```

Enter your database details: ```config/database.yml```

Start your rails server via ```rails s```

## Testing

This gem uses rspec. Simply run ```bundle exec rspec spec``` as usual.

You can run the whole test suite via ```bundle exec fudge build```

## Contribute

Please read our [contribution-guidelines](https://github.com/tyne/tyne/blob/master/CONTRIBUTING.md).

## Maintainers

* Tobias Haar (http://github.com/Tobscher)
* Michael Lessnau (http://github.com/mlessnau)

## License

MIT License. Copyright 2012 Tobias Haar.
