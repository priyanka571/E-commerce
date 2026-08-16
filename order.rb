require_relative 'cart'
require_relative 'product'
require 'csv'
class Order
    @@cart_file = 'cart.csv'
    @@order_file = 'order.csv'
	  @@product_file = 'products.csv'
  
    def self.view_order_history
			CSV.foreach(@@order_file, headers: true) do |row|
  			id = row['id']
				item = row['item']
				category = row['category']
				stock = row['stock'].to_i
				price = row['price'].to_i
				total_price = row['total_price'].to_i
				puts "#{id},#{item},#{category},#{stock},#{price},#{total_price}"
			end
    end

		def self.view_customer_orders
			puts "Enter customer name to search orders:"
  		customer_name = gets.chomp.strip.downcase
  		found = false
  		puts "\n===================== ORDERS PLACED BY: #{customer_name.upcase} ====================="
  		printf("%-6s | %-12s | %-12s | %-8s | %-10s | %-12s\n",
         "ID", "Item", "Category", "Quantity", "Price", "Total Price")
 			puts "-" * 70
  		CSV.foreach(@@order_file, headers: true) do |row|
    	placed_by = (row['placed_by'] || '').downcase
    	if placed_by == customer_name
      id          = row['id']
      item        = row['item']
      category    = row['category']
      stock       = row['stock']
      price       = row['price']
      total_price = row['total_price']
      printf("%-6s | %-12s | %-12s | %-8s | %-10s | %-12s\n",
             id, item, category, stock, price, total_price)
      found = true
      end
		end

	end

	 def self.place_orders
        Cart.view_cart
        puts "please choose product name from the list"
        @product= gets.chomp
				puts "please enter quantity"
				@quantity = gets.chomp
        product_found = false
        CSV.foreach(@@product_file, headers: true) do |row|
            id = row['id']
  	        item = row['item']
  	  			category = row['category']
						stock = row['stock'].to_i
   	  			price = row['price'].to_i
						placed_by = name
						if (@product == item && @quantity.to_i <= stock.to_i)
							total_price = price * @quantity.to_i
							CSV.open(@@order_file, 'a') do |csv|
								
								csv << [id,item,category,@quantity,price,total_price,placed_by]
    					end
							product_found = true

							table = CSV.table(@@product_file)
							@updated_stock = stock - @quantity.to_i
    					table.each do |row|
    					  if row[:item] == @product
    					      row[:stock] = @updated_stock 
    					    end
    					end
    					File.open(@@product_file, 'w') do |f|
    					  f.write(table.to_csv)
    					end	
							tab = CSV.table(@@cart_file)
							
    					tab.each do |row|
    					  if row[:item] == @product
    					      row[:stock] = nil
										row[:id]= nil
										row[:item] = nil
										row[:category]= nil
										row[:price] = nil

    					    end
    					end
    					File.open(@@cart_file, 'w') do |f|
    					  f.write(tab.to_csv)
    					end	
							break
            end
				end
				if product_found
         puts "item orders successfully"
				else
					puts "Product not found"
    	  end
		end
end
 