class ShoppingCartItem # < ActiveRecord::Base

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
  end

  def product
    @product
  end

  def id
    @product.id
  end

  def name
    @product.name
  end

  def price
    @product.price
  end

  def quantity
    @quantity
  end

  def quantity= (new_quantity)
    @quantity = new_quantity
  end
end