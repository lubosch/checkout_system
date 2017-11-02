require_relative 'item'
require_relative 'checkout_item'
require_relative 'promotions/item_promotion'
require_relative 'promotions/total_promotion'

class Checkout
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
    @items = []
  end

  def scan(item)
    @items << CheckoutItem.new(item)
  end

  def total
    apply_item_promotions
    original_price = @items.map(&:final_price).inject(:+)
    price = apply_total_promotions(original_price)
    price.round(2)
  end

  def apply_item_promotions
    item_promotions.each { |item_promotion| item_promotion.apply(@items) }
  end

  def apply_total_promotions(original_price)
    total_promotions.inject(original_price) do |current_price, total_promotion|
      total_promotion.apply(current_price)
    end
  end

  private

  def item_promotions
    @promotional_rules.select { |promotional_rule| promotional_rule.is_a?(Promotions::ItemPromotion) }
  end

  def total_promotions
    @promotional_rules.select { |promotional_rule| promotional_rule.is_a?(Promotions::TotalPromotion) }
  end
end
