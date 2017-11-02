module Promotions
  class ItemPromotion
    def initialize(item, amount, discount_price)
      @item = item
      @amount = amount
      @discount_price = discount_price
    end

    def apply(checkout_items)
      if applies?(checkout_items)
        promotion_items(checkout_items).each do |promotion_item|
          promotion_item.final_price = [promotion_item.final_price, @discount_price].min
          promotion_item.applied_promotions << self
        end
      end
    end

    private

    def applies?(checkout_items)
      promotion_items(checkout_items).count >= @amount
    end

    def promotion_items(checkout_items)
      checkout_items.select { |checkout_item| checkout_item.id == @item.id }
    end
  end
end
