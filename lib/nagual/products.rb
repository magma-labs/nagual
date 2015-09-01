module Nagual
  class Products

    def initialize
      @csv = CSV.new(File.read(path))
    end

    def to_hash
      @csv.to_hash(attribute_keys)
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
