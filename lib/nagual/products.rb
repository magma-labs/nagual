module Nagual
  class Products

    def initialize
      @csv = CSV.new(File.read(path))
    end

    def to_a
      @csv.to_a(attribute_keys)
    end

    private

    def attribute_keys
      Configuration.properties['products']['attribute_keys']
    end

    def path
      Configuration.properties['products']['file']
    end

  end
end
