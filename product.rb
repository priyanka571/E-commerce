class Products
    def self.add_products
        puts "Enter the product details to add\n id,name,category,stock,price"
        @product= gets.chomp
        file= File.new("products.csv","a")
        file.puts "#{@product}"
        file.close
        puts "Product added successfully"
    end

    def self.update_product
        # arr = IO.readlines("products.txt")
        products=File.readlines('products.csv').map { |line| line.chomp.split(',') }
        # puts products[1][1]
        view_products
        puts "Enter the product id you want to update"
        @id = gets.chomp
        puts "Enter the details you want to update please enter id as well"

        # @details = gets.chomp
        @details = gets.chomp.split(',').map(&:strip)
        products[@id.to_i ] = @details
        File.open('products.csv', 'w') do |file|
            products.each do |line|
                file.puts line.join(',')
            end
        end

        puts "Product updated successfully"
    end

    def self.del_product
        if !File.exist?("products.csv") || File.zero?("products.csv")
            puts "There is no product"
        else
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
end