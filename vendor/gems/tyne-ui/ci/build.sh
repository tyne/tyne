#!/usr/bin/env bash

bundle exec yard stats --list-undoc
bundle exec rspec spec && bundle exec rake spec:javascripts RAILS_ENV=test

exit $?
