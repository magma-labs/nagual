# Catalog tools to improve the work we do with Demandware
[![Build Status](https://travis-ci.org/sawyer-effect/nagual.svg?branch=master)](https://travis-ci.org/sawyer-effect/nagual)
[![Code Climate](https://codeclimate.com/github/sawyer-effect/nagual/badges/gpa.svg)](https://codeclimate.com/github/sawyer-effect/nagual)

For help running this code you can get the [Nagual VM](https://github.com/sawyer-effect/nagual-vm).

# Usage

* Create a `data/products.csv` file with the expected format, you can use
`data_examples/` as a reference
* Install the nagual gem
* Use the following command: `nagual catalog`
* A `data/catalog.xml` file will be generated.

## Custom attributes

If a new column is added with a header that is not recognized as a product
field, then a new custom attribute will be generated for the products
that contain a value for that column.

Example if column `season` and a product contains `winter` value, then
a product custom attribute with id "season" will be generated for
that product.

## Variations

To generate a new variation for products in the catalog a column needs to be
added in the csv file with the following format `variation-<NAME>` and in each
row a comma separated list of values is added for products.

For example to set a color variation a new column will be added as
`variation-color` and row can have values such as "blue,green" or "red"

### Variants

ariants will be automatically generated when a value for a variation is set
for a product.

The number of variants created for a product depends on how many variation
values are defined, for example if a product contains 3 different variation
values, then 9 variants will be generated, considering all the possible
combination of values.

## Images

We support 4 different types of images: `large, medium, small, swatch`

To set an image to a product, image sizes need to be listed in `images`
column of `products.csv`

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
