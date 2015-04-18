class UserSession
  def initialize(session)
    @session = session

    # set the shopping cart
    @session['cart'] ||= {}
    # set the cart products
    @session['cart']['products'] ||= {}
  end

  def cart_hash
    @session['cart']
  end

  def cart_products_hash
    @session['cart']['products']
  end

  def add_product_to_cart(product_id, quantity)
    quantity ||= 1
    product_id = product_id.to_s

    current_quantity = cart_products_hash.fetch(product_id, {}).fetch('quantity', 0)
    quantity += current_quantity

    cart_products_hash[product_id] = { 'quantity' => quantity }
  end

  def remove_product_from_cart(product_id)
    product_id = product_id.to_s
    cart_products_hash.delete(product_id)
  end
end