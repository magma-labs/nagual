module Nagual
  class Database
    def self.load(model)
      new(model).to_a
    end

    def initialize(model)
      @model = model
      @csv   = CSV.new(File.read(path))
    end

    def to_a
      @csv.to_a(attribute_keys)
    end

    private

    def attribute_keys
      Configuration.properties[@model]['attribute_keys']
    end

    def path
      Configuration.properties[@model]['file']
    end
  end
end
