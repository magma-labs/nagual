module Nagual
  class ProductVariation
    attr_reader :id, :values

    def initialize(id: nil, values: [])
      @id = id
      @values = values
    end

    class Value
      attr_reader :display

      def initialize(display)
        @display = display
      end

      def value
        @display.tr(' ', '-').downcase
      end
    end
  end
end
