locals {
  services = {
    product = {
      repo = "ecommerce/product_service"
      #path = "../product_service"
    }
    cart = {
      repo = "ecommerce/cart_service"
      #path = "../cart_service"
    }
    user = {
      repo = "ecommerce/user_service"
      #path = "../user_service"
    }
    order = {
      repo = "ecommerce/order_service"
      #path = "../order_service"
    }
  }
}
locals {

    region = "us-east-1"
}