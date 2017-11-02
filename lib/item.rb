class Item
  attr_accessor :price, :id, :name

  def initialize(id, name, price)
    @id = id
    @name = name
    @price = price
  end
end
