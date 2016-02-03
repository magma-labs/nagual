require 'nagual/configuration'
require 'nagual/xml/catalog'
require 'nagual/csv/input'
require 'nagual/catalog'

module Nagual
  def self.catalog(input_path)
    products = CSV::Input.new(input_path).products
    catalog  = Catalog.new(products)

    XML::Catalog.new(catalog).output
  end
end
