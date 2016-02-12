module Nagual
  module Models
    class Catalog
      def initialize(products)
        @products = products
      end

      attr_reader :products

      def attributes
        {
          xmlns:        'http://www.demandware.com/xml/impex/catalog/2006-10-31',
          'catalog-id': 'nagual-catalog'
        }
      end
    end
  end
end
