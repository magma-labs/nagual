require 'nagual/configuration'
require 'nagual/xml/catalog'
require 'nagual/csv/input'
require 'nagual/catalog'

module Nagual
  def self.catalog(input: CSV::Input.new, builder_class: XML::Catalog)
    products = input.products
    builder  = builder_class.new(Catalog.new(products))

    builder.output
  end
end
