##Catalog tools to improve the work we do with Demandware [![Build Status](https://travis-ci.org/sawyer-effect/nagual.svg?branch=master)](https://travis-ci.org/sawyer-effect/nagual)

For help running this code you can get the [Nahual VM](https://github.com/sawyer-effect/nagual-vm).

## Setup

* Install ruby
* Install bundler
* Install dependencies with bundler: `bundle install`

## Run

* Create `data/input.csv` file with expect format
* Use rake command: `bundle exec rake run`
* File `data/output.xml` will be created

**NOTE: Input and output location can be edited in configuration file**

## Test

Run the test by doing: `bundle exec rake spec`
