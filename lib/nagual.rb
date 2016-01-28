require 'nagual/catalog'
require 'nagual/configuration'
require 'nagual/input'
require 'nagual/product'
require 'nagual/xml/catalog'

module Nagual
  def self.catalog(input_file = Configuration.properties['input_file'])
    products = Input.new(File.read(input_file)).products

    XML::Catalog.new(Catalog.new(products)).output
  end
end
