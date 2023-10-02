## TRES ICE-CREAM

order_bot <- function() {
  print("Welcome to TRES ice cream.")
  username = readline("What is your name : ")
  print(paste("Hello",username))
  
  print("We have 5 flavours ice cream :Stawberry, Chocolate, Lime, Lemon, Yogurt")
  user_choice = readline("What flavours do you want : ")
  print(paste("Ok you choose",user_choice))
  
  print("We have 2 size: L, XL")
  user_size = readline("What size do you want : ")
  print(paste("You choose size", user_size))
  
  
  ship_address = readline("Please enter your delivery address and phone number  : ")
  print(paste("Thank you for shopping with us ",username))
}
order_bot()
