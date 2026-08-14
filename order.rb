require_relative 'cart'
require 'csv'
class Order
    @@cart_file = 'cart.csv'
    @@order_file = 'order.csv'
    def self.place_orders
        puts "enter the name of product you want to place"
        @item = gets.chomp
				puts "enter the quantity of product"
				@quantity = gets.chomp

        CSV.foreach(@@cart_file, headers: true) do |row|
            id = row['id']
  	        item = row['item']
  	  			category = row['category']
						stock = row['stock'].to_i
   	  			price = row['price'].to_i
						p item
						p @item
						p @quantity.to_i
						p stock
						# if (item == @item && @quantity.to_i <=stock)
							if (@item == item && @quantity.to_i <= stock.to_i)
							total_price = price * @quantity.to_i
							CSV.open(@@order_file, 'a') do |csv|
								csv << [id,item,category,@quantity,price,total_price]
								p "item add"
    					end
							# product_found = true

							table = CSV.table(@@cart_file)
							@updated_stock = stock - @quantity.to_i
    					table.each do |r|
    					  if r[:item] == @item
    					    r[:stock] = @updated_stock 
    					  end
    					end
    					File.open(@@cart_file, 'w') do |f|
    					  f.write(table.to_csv)
    					end	
							break
            end
				end
    end
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
end
 