require_relative 'admin'
class EcomApp
    
    def sign_up
    
        puts "Welcome to the Ecommerce"
        puts "Sign In"
        puts "enter your name"
        @name = gets.chomp
        puts "enter your 4 digit PIN"
        @pin = gets.chomp
        # @count = 0
        # @total_num = @pin
        # while total_num!=0
        #     @count += 1
        #     @total_num /=10
            
        # end
        # puts count
        # if @count !=4
        #     puts "please enter 4 digit pin"
        # end
            
        
        
       
        File.open("user.csv", "a+") { |f| f.write("#{@name},#{@pin}\n") }
        puts "Sign in Successfully"

        # login
    end
    def login
        puts "Welcome to the Ecommerce"
        puts "Login"
        @attempt = 3
        @used_attempt =0
        3.times do
            puts "Please enter name"
            @name = gets.chomp.downcase
            puts "please enter 4 digit PIN"
            @pin = gets.chomp
            puts "please enter your role"
            @role = gets.chomp.downcase
            File.foreach("user.csv") do |line|
                if line=~ /@name/ and line=~ /@pin/
                    if @role == admin




        end
    end




end
ecom = EcomApp.new
ecom.sign_up

    