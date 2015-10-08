module Nagual
  class Input
    def self.load(model, path)
      new(model, path).to_a
    end

    def initialize(model, path)
      @model = model
      @path  = path
    end

    def to_a
      CSV.new(file).to_a(attribute_keys)
    end

    private

    def file
      File.read("#{@path}/#{@model}.csv")
    end

    def attribute_keys
      Configuration.properties[@model]['attribute_keys']
    end
  end
end
