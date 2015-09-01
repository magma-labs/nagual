module Nagual
  class Images

    def initialize
      @csv = CSV.new(File.read(path))
    end

    def to_a
      @csv.to_a(attribute_keys)
    end

    private

    def attribute_keys
      Configuration.properties['images']['attribute_keys']
    end

    def path
      Configuration.properties['images']['file']
    end

  end
end
