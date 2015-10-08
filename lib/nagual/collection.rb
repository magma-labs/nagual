module Nagual
  class Collection
    def initialize(content)
      @content = content
    end

    def to_a
      @content
    end

    private

    def new(content)
      self.class.new(content)
    end
  end
end
