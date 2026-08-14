require_relative 'admin'
require_relative 'customer'
class EcomApp
    
    def self.sign_up
    
        puts "Welcome to the Ecommerce"
        puts "login or SignIn"
        reg = gets.chomp
        if(reg == "SignIn")
            puts "Sign In"
            puts "enter your name"
            @name = gets.chomp
            puts "enter your 4 digit PIN"
            @pin = gets.chomp 
            @role = customer  
            File.open("user.csv", "a+") { |f| f.write("#{@name},#{@pin},#{@role}\n") }
            puts "Sign in Successfully"
            EcomApp.login
        else
            EcomApp.login
        end
    end
    def self.login
        puts "Welcome to the Ecommerce"
        puts "Login"
       
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
  
             redo if ((@name.strip.empty? && @pin.strip.empty?) &&  @used_attempt <3)
            @pwd=@pin.to_i
  
            File.open("user.csv","r") do |file|
                file.each_line do |line|
                arr = line.split(",")
                if(arr[0] == @name && arr[1] == @pin)
                    puts "logged In Successfully"

                     case
                     when arr[2].downcase == "admin"
                        AdminLogin.run
                    #  when arr[2].downcase == "customer"
                    #   Customer.call
                     else
                        puts "login failed"  
                     end


                end
            

            end



        end
    end



end
end
EcomApp.sign_up


    