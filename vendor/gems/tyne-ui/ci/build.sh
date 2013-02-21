#!/usr/bin/env bash

bundle install
bundle exec yard stats --list-undoc
bundle exec rspec spec && bundle exec rake spec:javascripts RAILS_ENV=test

exit $?
