module Nagual
  class ProductVariation
    attr_reader :id, :values

    def initialize(id: nil, values: [])
      @id = id
      @values = values
    end
  end
end
