# frozen_string_literal: true

module INSS
  class DiscountTable
    attr_reader :table

    DiscountTableItem = Struct.new(:min_range, :max_range, :discount_percentage)

    def initialize
      @table = [
        DiscountTableItem.new(0.00, 1045.00, 0.075),
        DiscountTableItem.new(1045.01, 2089.60, 0.09),
        DiscountTableItem.new(2089.61, 3134.40, 0.12),
        DiscountTableItem.new(3134.41, 6101.06, 0.14)
      ]
    end

    def call
      @table
    end
  end
end
