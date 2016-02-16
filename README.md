# Catalog tools to improve the work we do with Demandware
[![Build Status](https://travis-ci.org/sawyer-effect/nagual.svg?branch=master)](https://travis-ci.org/sawyer-effect/nagual)
[![Code Climate](https://codeclimate.com/github/sawyer-effect/nagual/badges/gpa.svg)](https://codeclimate.com/github/sawyer-effect/nagual)

For help running this code you can get the [Nagual VM](https://github.com/sawyer-effect/nagual-vm).


# Usage

## Setup

* Create a `config/configuration.yml` file with expected format and customize
* Create a `data/products.csv` file with the expected format, you can use
`data_examples/` as a reference

## Nagual Command

* Install the nagual gem
* Use the following commands:
    * `nagual review` - to validate input and see if there are invalid rows, an `error_report`
        will be generated with information about input data.
    * `nagual export` - to generate a `catalog.xml` (only valid products will be used)
* By default nagual will read from a csv and out put a catalog xml file, location of
    input and output files can be modified in `configuration.yml` file

## Nagual API

* If you rather use the gem inside your project you can use it like this:

```ruby
nagual = Nagual::API.new
puts nagual.transform(:csv, :xml_catalog)
puts nagual.transform(:csv, :error_report)
```

## Mapping

## Product attributes

All valid product attributes can be mapped from a csv file using the
mapping section of the `configuration.yml` file, the key is the
expected column name in input file and value is the product field name.

## Ignore columns

If a column is not mapped in configuration file it will be ignored.

## Custom attributes

If a column is mapped but there is not product field with that name,
then a custom attribute will be generated for that value.

## Variations

To generate a new variation for products in the catalog a column needs to be
added in the csv file and then added to the `variations` section for mapping
the expected value for each row is either a comma separated list of values
or blank.

For example to set a color variation a new column will be added as
`color` and row can have values such as "blue,green" or "red"

### Variants

Variants will be automatically generated when a value for a variation is set
for a product.

The number of variants created for a product depends on how many variation
values are defined, for example if a product contains 3 different variation
values, then 9 variants will be generated, considering all the possible
combination of values.

## Images

We support 4 different types of images: `large,medium,small,swatch`

To set an image to a product, image sizes need to be listed in `images`
column of `products.csv`

The column name for images can be modified in mapping section of `configuration.yml`

And then image is expected to be located in `images` folder with this format:
`<PRODUCT_ID>_<SIZE>.png`

For example:

If we want product with id "123" to have medium and swatch images then on the
column for images in the products row, `medium,swatch` value will be added.

And then on `images` folder `123_medium.png` and `123_swatch.png` files
are expected to be present.

# Nagual development

* Install ruby
* Install bundler
* Install dependencies with bundler: `bundle install`
* User `rspec` command to run tests
