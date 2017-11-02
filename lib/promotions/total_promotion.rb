module Promotions
  class TotalPromotion
    def initialize(discount_price_point, percentage_discount)
      @discount_price_point = discount_price_point
      @percentage_discount = percentage_discount
    end

    def apply(price)
      price > @discount_price_point ? price * (1 - @percentage_discount / 100.0) : price
    end
  end
end
