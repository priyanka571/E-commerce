require_relative 'product'
require_relative 'order'
require_relative 'cart'
# require_relative 'order'

class Customer
    def self.display_menu
        
            puts "E-commerce website"
            puts " Press 1  To View Product"
            puts " Press 2  To Search Product details"
            puts " Press 3  To Add Products to cart"
            puts " Press 4  To Remove Product from cart"
            puts " Press 5  To Update Product quantity"
            puts " Press 6  To View cart"
            puts " Press 7  To Place Orders"
            puts " Press 8  To View Order history"
            puts " Press 9 To exit"
            puts "choose between 1-9"
        
    end
     def self.run(id,name)
        loop do
            display_menu
            choice = gets.chomp.to_i
            case choice
            when 1
                Products.view_products
            when 2
                Products.search_product
            when 3
                Cart.add_product_cart
            when 4
                Cart.remove_product_cart
            when 5
                Cart.update_product_quantity
            when 6
                Cart.view_cart
            when 7
                Order.place_orders
            when 8
                Order.view_order_history
            when 9
                break
            else
                puts "You made a wrong choice"
            end
        end
    end
end
