##Catalog tools to improve the work we do with Demandware [![Build Status](https://travis-ci.org/sawyer-effect/nagual.svg?branch=master)](https://travis-ci.org/sawyer-effect/nagual)

For help running this code you can get the [Nagual VM](https://github.com/sawyer-effect/nagual-vm).

## CSV file > Demandware catalog file.

* Create a `data` file with the expected format, you can use `data_examples/` as a reference
* Install the nagual gem
* Use the following command: `nagual catalog`
* A file will be generated in `data/output.xml`

## Nagual development

* Install ruby
* Install bundler
* Install dependencies with bundler: `bundle install`
* User `rspec` command to run tests
