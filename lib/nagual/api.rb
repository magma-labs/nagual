require 'nagual/input'
require 'nagual/conversion'
require 'nagual/output'

module Nagual
  class API
    def transform(type, origin, destination)
      rows       = Input.from(origin).read
      conversion = Conversion.for(type).parse(rows)

      Output.to(destination).write!(conversion.objects, conversion.errors)
    end
  end
end
