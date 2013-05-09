# Contribution Guidelines

## Submitting a new issue

If you need to submit a new issue please go to: http://app.tyne-tickets.org/Tobscher/TYNE/issues/new

## Merging requests

If you have permissions to merge pull requests please ensure the code has been reviewed and all the comments have been addressed.
Please make sure that the current build is not broken before you merge any code changes: https://travis-ci.org/tyne/tyne

## Making a pull request

If you'd like to submit a pull request and contribute to the project please ensure your pull request meets the following requirements:

1. Your code is fully documented. We are using [YARD](http://yardoc.org/) to ensure 100% documentation coverage.
2. Your code is fully tested. We are using [SimpleCov](https://github.com/colszowka/simplecov) to ensure 100% code coverage.
3. You have merged with master.
4. You have ran the test suite and it passes. You have to run ```script/ci``` from the top level of your project.
