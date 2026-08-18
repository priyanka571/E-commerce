require_relative 'product'
require 'csv'
class Cart
    @@cart_file = 'cart.csv'
		@@product_file = 'products.csv'
    def self.add_product_cart
        Products.view_products
        puts "please choose product name from the list"
        @product= gets.chomp
				puts "please enter quantity"
				@quantity = gets.chomp
        @product_found = false
        CSV.foreach(@@product_file, headers: true) do |row|
            id = row['id']
  	        item = row['item']
  	  			category = row['category']
						stock = row['stock'].to_i
   	  			price = row['price'].to_i
						if (@product == item && @quantity.to_i <= stock.to_i)
							total_price = price * @quantity.to_i
							CSV.open(@@cart_file, 'a') do |csv|
								
								csv << [id,item,category,@quantity,price,total_price]
    					end
							@product_found = true
							break
            end
				end
				if @product_found
         puts "item added successfully in cart"
				else
					puts "Product not found"
    	  end
		end

    def self.remove_product_cart


			 if !File.exist?("cart.csv") || File.zero?("cart.csv")
            puts "There is no product"
        else
            view_cart
            puts "Enter the product id. you want to delete"
            @item = gets.chomp
            products=File.readlines('cart.csv').map { |line| line.chomp.split(',') }
            deleted_rows = products.reject! { |row| row[0] == @item }


            if deleted_rows
            
              File.open('cart.csv', 'w') do |file|
                  products.each { |row| file.puts row.join(',') }
              end
              puts "Product with ID #{@item} was deleted successfully."
            else
              puts "Product ID #{@item} not found."
            end
            
        end

			# puts "Enter the product name. you want to delete"
      # @item = gets.chomp
			# CSV.foreach(@@cart_file, headers: true) do |row|
      #       id = row['id']
  	  #       product = row['item']
  	  # 			category = row['category']
			# 			quantity = row['quantity'].to_i
   	  # 			price = row['price'].to_i
			# 			total = row['total'].to_i
			# 			@product_found = false
						
			# 			if (@item == product)
			# 				@product_found = true
							
			# 				table = CSV.table(@@cart_file)
    	# 				table.each do |row|
    	# 				  if row[:item] == @item
    	# 				      # row[:id] = nil
			# 							# row[:item] = nil
			# 							# row[:category] = nil
			# 							# row[:stock] = nil
			# 							# row[:price] = nil
			# 							# row[:total] = nil 
			# 							# table.reject! { |row| row[:item] == @item }
			# 							# table.reject! row
    	# 				  end
    	# 			  end
    	# 			  File.open(@@cart_file, 'w') do |f|
    	# 			  	f.write(table.to_csv)
    	# 				end	
			# 				break
      #    		end
			# 	end
			# 	if @product_found
			# 		puts "item deleted Successfully"
			# 	else
			# 		puts "items not found"
			# 	end
    end

    def self.update_product_quantity
			view_cart
			puts "enter the product name who's quantity you want to update"
			@item = gets.chomp
			puts "enter the updated quantity"
			@quantity = gets.chomp
			
			
			table = CSV.table(@@product_file)

      table.each do |row|
      	if row[:item] == @item && @quantity.to_i <=row[:stock].to_i
						tab = CSV.table(@@cart_file)
    				tab.each do |r|
      				if r[:item] == @item
          				r[:stock] = @quantity
        			end
    				end
    				File.open(@@cart_file, 'w') do |f|
      				f.write(tab.to_csv)
    				end
						puts "Quantity updated successfully"

      	end
    	end
    	
      
    end
    def self.view_cart
			CSV.foreach(@@cart_file, headers: true) do |row|
  	  	id = row['id']
  	  	item = row['item']
  	  	category = row['category']
				stock = row['stock']
   	  	price = row['price']
			  puts "#{id},#{item},#{category},#{stock},#{price}"
	    end 
    end
	
end





