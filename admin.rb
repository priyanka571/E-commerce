require_relative 'product'
require_relative 'order'
class AdminLogin
   
    def self.display_menu
			puts "E-commerce website"
			puts " Press 1  To add Product"
			puts " Press 2  To update Product details"
			puts " Press 3  To Delete Product"
			puts " Press 4  To View all Products"
			puts " Press 5  To Search Product"
			puts " Press 6  To update Product Stock"
			puts " Press 7  To view customer Orders"
			puts " Press 8  To exit"
			puts "choose between 1-7"
    end

    def self.run(id,name)
			loop do
					display_menu
					choice = gets.chomp.to_i
					case choice
					when 1
						Products.add_products
					when 2
						Products.update_product
					when 3
						Products.del_product
					when 4
						Products.view_products
					when 5
						Products.search_product
					when 6
						Products.update_product_stock
					when 7
						Order.view_customer_orders
					when 8
						break
					else
						puts "You made a wrong choice"
					end
			end
    end
end
# AdminLogin.run


   





