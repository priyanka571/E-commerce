require 'csv'
class Products
    @@csv_file = 'products.csv'

    def self.product_id
    	max_id = 0
    	CSV.foreach(@@csv_file, headers: true) do |row|
      	id_val = (row['id']).to_i
				if id_val > max_id
					max_id = id_val 
				end
    	end
   		max_id + 1
  	end	

    def self.add_products
        id = product_id 
        puts "Enter Product Name:"
        name = gets.chomp.strip
        puts "Enter Category:"
        category = gets.chomp.strip
        puts "Enter Stock Quantity:"
        stock = gets.chomp.strip.to_i
        puts "Enter Price:"
        price = gets.chomp.strip.to_f
        CSV.open(@@csv_file, 'a') do |csv|
          csv << [id, name, category, stock, price]
        end
        puts "Product '#{name}' added successfully"
    end

    def self.update_product
        
        products=File.readlines('products.csv').map { |line| line.chomp.split(',') }
        
        view_products
        puts "Enter the product id you want to update"
        id = gets.chomp
        table = CSV.table(@@csv_file)
        product_found = false
         puts "Enter which detail you want to update\n 1.for item\n 2. for category\n 3. for stock\n 4. for price"
        update = gets.chomp

        table.each do |row|
          if row[:id].to_s == id
            p update
            p 1
            product_found = true
       
          if update.to_i == 1
            puts "enter updated item name"
            new_name = gets.chomp
            row[:item] = new_name
          elsif update.to_i == 2
            puts "enter updated category"
            new_category = gets.chomp
            row[:category] = new_category
          elsif update.to_i == 3
            puts " enter updated stock"
            new_stock = gets.chomp
            row[:stock] = new_stock
          elsif update.to_i == 4
            puts "enter updated price"
            new_price = gets.chomp
            row[:price] = new_price
          else
            puts "wrong choice"
          end
        end
      end


      if product_found
        File.write(@@csv_file,table.to_csv)
        puts "Product ID #{id} updated successfully!"
      else
        puts "Product Not found"
      end
       
    end

    def self.del_product
        if !File.exist?("products.csv") || File.zero?("products.csv")
            puts "There is no product"
        else
            view_products
            puts "Enter the product id. you want to delete"
            @item = gets.chomp
            products=File.readlines('products.csv').map { |line| line.chomp.split(',') }
            deleted_rows = products.reject! { |row| row[0] == @item }


            if deleted_rows
            
              File.open('products.csv', 'w') do |file|
                  products.each { |row| file.puts row.join(',') }
              end
              puts "Product with ID #{@item} was deleted successfully."
            else
              puts "Product ID #{@item} not found."
            end
            
        end
    end




   def self.view_products
        # file= File.new("products.txt","r")
        if File.zero?("products.csv")
          puts "There is no product"
        else
          lines_count = 0
          puts "Products are :"
          IO.foreach("products.csv"){|item| puts  item}
        end
    end

	def self.search_product
  	puts "Enter the product name to search"
  	@item = gets.chomp.strip.downcase

    found_product =[]
  	CSV.foreach(@@csv_file, headers: true) do |row|
  	  id = row['id'].to_s.downcase
  	  item = row['item'].to_s.downcase
  	  category = row['category'].to_s.downcase
			stock = row['stock'].to_i
   	  price = row['price'].to_i
		  if (item.include?(@item) || category.include?(@item))
			 found_product << row
		  end
	  end 
    if found_product.empty?
      puts "No item found"
    else
      puts "Search Result"
      found_product.each do |row|
        printf("%-6s | %-18s | %-15s | %-8s | %-10s\n",
        row['id'], row['item'], row['category'], row['stock'], row['price'])
      end
    end
	end
	def self.update_product_stock
		puts "Enter the product name to update their stock"
  	@item = gets.chomp
		# Products.search_product
		puts "Enter the updated stock"
		@stock = gets.chomp
    table = CSV.table(@@csv_file)

    table.each do |row|
      if row[:item] == @item
          row[:stock] = @stock 
        end
    end
    File.open(@@csv_file, 'w') do |f|
      f.write(table.to_csv)
    end
    puts "Stock of #{@item} is updated successfully to #{@stock}"

	end
end
