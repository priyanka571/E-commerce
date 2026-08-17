require_relative 'admin'
require_relative 'customer'
require 'csv'
# require_relative 'customer'
class EcomApp
    
    def self.sign_up
    
        puts "Welcome to the Ecommerce"
        puts "login or Signup"
        reg = gets.chomp.downcase
        if(reg == "signup")
            puts "Sign up"
            puts "enter user id"
            @id = gets.chomp
            puts "enter your name"
            @name = gets.chomp
            name = @name
            puts "enter your 4 digit PIN"
            @pin = gets.chomp 
            @role = "customer"  
            File.open("user.csv", "a+") { |f| f.write("#{@id},#{@name},#{@pin},#{@role}\n") }
            puts "Registered Successfully"
            EcomApp.login
        else
            EcomApp.login
        end
    end
    def self.login
        puts "Welcome to the Ecommerce"
        puts "Login"
        csv_file = 'user.csv'
       
        @used_attempt =0
        3.times do
            @used_attempt +=1
            puts "Please enter name"
            @name = gets.chomp.downcase
            puts "please enter 4 digit PIN"
            @pin = gets.chomp
            puts "please enter your role"
            @role = gets.chomp.downcase

            if(@used_attempt>=3 && @name.strip.empty? && @pin.strip.empty?)
                puts "three attemps failed"
                exit
            end
  
            if ((!@name.strip.empty? && !@pin.strip.empty?) &&  @used_attempt <3)
                    @pin=@pin.to_i
                
                CSV.foreach(csv_file, headers: true) do |row|
										id = row['ID']
                    name = row['Name']
                    pin = row['Pin']
                    role = row['Role']
										p row
                    
                    if(name.downcase == @name && pin.to_i == @pin)
                        puts "logged In Successfully"
                        case
                         when role.downcase == "admin"
                            AdminLogin.run(id,name)
                         when role.downcase == "customer"
                            Customer.run(id,name)
                         else
                            puts "Something went wrong"  
                         end
                    end
                    
            

                end
         
        end

				break

    end
end
end
EcomApp.sign_up


    