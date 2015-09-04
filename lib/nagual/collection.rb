module Nagual
  class Collection
    def initialize(content)
      @content = content
    end

    def add_image_groups(groups, images)
      groups_with_images = CSV.add_children(groups, :images, images, :image)

      new(CSV.add_children(@content, :images,
                           groups_with_images, :'image-group'))
    end

    def add_page_attributes(attributes)
      new(CSV.add_children(@content, :'page-attributes', attributes))
    end

    def add_bundled_products(bundled)
      new(CSV.add_children(@content, :'bundled-products',
                           bundled, :'bundled-product'))
    end

    def add_set_products(sets)
      new(CSV.add_children(@content, :'product-set-products',
                           sets, :'product-set-product'))
    end

    def add_options(options, values, prices)
      values_with_prices = CSV.add_children(values, :'option-value-prices',
                                            prices, :'option-value-price')
      options_with_vals = CSV.add_children(options, :'option-values',
                                           values_with_prices, :'option-value')

      new(CSV.add_children(@content, :options, options_with_vals, :option))
    end

    def add_product_links(links)
      new(CSV.add_children(@content, :'product-links', links, :'product-link'))
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
