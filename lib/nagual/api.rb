require 'nagual/input'
require 'nagual/mapping'
require 'nagual/output'

module Nagual
  class API
    def transform(origin, destination)
      rows    = Input.from(origin).read
      mapping = Mapping.parse(rows)

      Output.to(destination).write!(mapping.objects, mapping.errors)
    end
  end
end
