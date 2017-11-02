class CheckoutItem
  attr_accessor :final_price, :id, :applied_promotions

  def initialize(item)
    @item = item
    @final_price = @item.price
    @id = item.id
    @applied_promotions = []
  end
end
