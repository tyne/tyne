# tyne

[![travis-ci](https://api.travis-ci.org/tyne/tyne.png)](http://travis-ci.org/#!/tyne/tyne) [![Dependency Status](https://gemnasium.com/tyne/tyne.png)](https://gemnasium.com/tyne/tyne) [![Code Climate](https://codeclimate.com/github/tyne/tyne.png)](https://codeclimate.com/github/tyne/tyne) [![Coverage Status](https://coveralls.io/repos/tyne/tyne/badge.png?branch=master)](https://coveralls.io/r/tyne/tyne)

## Description

Tyne is a webbased issue tracking application with the following features:
* Github authentication
* Project management
* Issue tracking (includes sorting, filtering, basic workflow, etc.)
* Basic role management
* Agile sprint planning
* Scrum board
* Commenting system
* Voting system
* Charts (Burn Down Chart, etc.)

Do you want to check the current status of the project? We have deployed a demo to http://www.tyne-tickets.org

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

You can run the following command to run the whole test script: ```script/ci```

## Contact us

Please don't hesitate to ask any questions at our google groups.

For general questions please use the following discussion list: [tyne-talk@googlegroups.com](http://groups.google.com/group/tyne-talk)

If you have questions to the internals of tyne or just want to propose some changes, please use the following discussion list: [tyne-core@googlegroups.com](http://groups.google.com/group/tyne-core)

## Contribute

Please read our [contribution-guidelines](https://github.com/tyne/tyne/blob/master/CONTRIBUTING.md).

Note Also that this repository contains submodules so cloning is best done like so:

```bash
git clone --recursive git@github.com:tyne/tyne.git
```

Or if you have already cloned it, run this in your repo root:

```bash
git submodule init
git submodule update
```

## Changelog

Click [here](https://github.com/tyne/tyne/blob/master/CHANGELOG.md) to view the changelog.

## Maintainers

* Tobias Haar (http://github.com/Tobscher)
* Michael Lessnau (http://github.com/mlessnau)

## License

MIT License. Copyright 2012 - 2013 Tobias Haar.
