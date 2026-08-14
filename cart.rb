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
        product_found = false
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
							break
            end
				end
				if product_found
         puts "item added successfully in cart"
				else
					puts "Product not found"
    	  end
		end

    def self.remove_product_cart
			puts "Enter the product name. you want to delete"
      @item = gets.chomp
			CSV.foreach(@@cart_file, headers: true) do |row|
            id = row['id']
  	        product = row['product']
  	  			category = row['category']
						quantity = row['quantity'].to_i
   	  			price = row['price'].to_i
						total = row['total'].to_i
						product_found = false
						if (@item == product)
							product_found = true
							table = CSV.table(@@cart_file)
    					table.each do |row|
    					  if row[:product] == @item
    					      row[:id] = nil
										row[:product] = nil
										row[:category] = nil
										row[:quantity] = nil
										row[:price] = nil
										row[:total] = nil 
    					  end
    				  end
    				  File.open(@@cart_file, 'w') do |f|
    				  	f.write(table.to_csv)
    					end	
							break
         		end
				end
				if product_found
					puts "item deleted Successfully"
				else
					puts "items not found"
				end
    end

    def self.update_product_quantity
			puts "enter the product name who's quantity you want to update"
			@item = gets.chomp
			puts "enter the updated quantity"
			@quantity = gets.chomp
			
			
			table = CSV.table(@@cart_file)

      table.each do |row|
      	if row[:item] == @item
					temp = row[:quantity]
          row[:quantity] = @quantity
					diff = temp.to_i - @quantity.to_i
					p temp.to_i
					p @diff
					p @quantity.to_i
					
						table = CSV.table(@@product_file)
    				table.each do |row|
      				if row[:item] == @item
								if @diff > 0
          				row[:stock] = row[:stock] + diff.to_i
								else
									row[:stock] = row[:stock] - diff.to_i
								end

        			end
    				end
    				File.open(@@product_file, 'w') do |f|
      				f.write(table.to_csv)
    				end

      	end
    	end
    	File.open(@@cart_file, 'w') do |f|
      	f.write(table.to_csv)
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





