module Nagual
  class ProductVariation
    attr_reader :id, :values

    def initialize(id: nil, values: [])
      @id = id
      @values = values
    end

    class Value
      attr_reader :value, :display

      def initialize(value: nil, display: nil)
        @value   = value
        @display = display
      end
    end
  end
end
