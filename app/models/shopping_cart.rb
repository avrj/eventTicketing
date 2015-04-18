class ShoppingCart

  def initialize(session)
    @session = session
    @products = get_products_from_session
  end

  def get_products_from_session
    products = @session.cart_products_hash

    items = []

    products.keys.each do |product_id|
      product = Product.find_by(id: product_id.to_i)

      if product
        item = ShoppingCartItem.new(product, products[product_id]['quantity'])
        items << item if item
      else
        # If the product was not found in the database -> remove it from the cart
        @session.remove_product_from_cart(product_id)
      end
    end

    items
  end

  def products
    @products
  end
end