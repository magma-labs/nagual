require 'nagual/configuration'
require 'nagual/xml/catalog'
require 'nagual/csv/input'
require 'nagual/catalog'

module Nagual
  class << self
    def catalog(input_path)
      input   = CSV::Input.new(input_path)
      catalog = Catalog.new(input.valid_products)

      print_invalid_products(input.invalid_products)
      XML::Catalog.new(catalog).output
    end

    private

    def print_invalid_products(products)
      p 'OK' if products.empty?
      products.each do |product|
        p "Product with id: #{product.product_id} " \
          "has the following errors: #{product.errors}"
      end
    end
  end
end
