# tyne-ui

[![travis-ci](https://secure.travis-ci.org/tyne/tyne-ui.png)](http://travis-ci.org/#!/tyne/tyne-ui) [![Dependency Status](https://gemnasium.com/tyne/tyne-ui.png)](https://gemnasium.com/tyne/tyne-ui) [![Code Climate](https://codeclimate.com/github/tyne/tyne-ui.png)](https://codeclimate.com/github/tyne/tyne-ui)

## Description

tyne-ui is a submodule of a larger project called [tyne](https://github.com/tyne/tyne).  Tyne is a webbased issue tracking application.

This gem serves [tyne](https://github.com/tyne/tyne) with the following components:
* CSS stylesheets
* JavaScript components (e.g. Widgets)

## Installation

This library is only used by [tyne](https://github.com/tyne/tyne) and doesn't need to be installed.

## Testing

You can run the Evergreen specs by running the dummy application in test environment and navigating to /evergreen:
```
cd spec/dummy
rails s -e test
```

There is also a rake task that allows you to run your specs: ```bundle exec rake spec:javascripts RAILS_ENV=test```
Note that you have to define your environment.

You can run the whole test suite via ```./ci/build.sh```

## Contribute

Please read our [contribution-guidelines](https://github.com/tyne/tyne-ui/blob/master/CONTRIBUTING.md).

## Maintainers

* Tobias Haar (http://github.com/Tobscher)
* Michael Lessnau (http://github.com/mlessnau)

## License

MIT License. Copyright 2012 Tobias Haar.
