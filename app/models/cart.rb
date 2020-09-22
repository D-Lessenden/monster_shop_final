class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    @contents.map do |item_id, _|
      item = Item.find(item_id)
      discount = assess_discount(item)
      item.price = item.price * (1 - (discount.percent / 100.0)) if discount
      item
    end
  end

  def assess_discount(item)
    discount = Discount.where(merchant_id: item.merchant.id).where("num_of_items <= ?", count_of(item.id)).max_by(&:percent)
  end

  def grand_total
    total = 0
    @contents.map do |item_id, _|
      item = Item.find(item_id)
      discount = assess_discount(item)
      item.price = item.price * (1 - (discount.percent / 100.0)) if discount
      total += @contents[item_id.to_s] * item.price
    end
    total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    item = Item.find(item_id)
    discount = assess_discount(item)
    item.price = item.price * (1 - (discount.percent / 100.0)) if discount
    @contents[item_id.to_s] * item.price
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end
end
