Pao_Ying_Chub_Game <- function() {
  user_score <- 0
  ai_score <- 0
  
  options <- c("h", "p", "s")
  print("h = hammer, p = paper, s = scissor")
  print("type one of this choice to play game")
  print(options)
  print("Instruction type 'e' for exit the game")
  yname <- readline("What your name : ")

  while(T){
    user_select <- readline("Choose one : ")
    if(user_select == "e"){
      print(paste(toupper(yname), " score is ",user_score, "and",
                  "Ai score is ",ai_score))
      if(user_score > ai_score) {
        print(paste(toupper(yname), " win this game"))
        }else if(user_score < ai_score){
          print(paste(toupper(yname), " lose this game"))
        }else{
          print("Tie")
        }
      print(paste("Thank you," ,toupper(yname), "for playing game"))
      break
      
    }
    ai_select <- sample(options, 1)
    print(paste("Ai select ", ai_select))
    if ((user_select == "h")&(ai_select == "s")){
      user_score <- user_score + 1
      print("Your win")
    }else if((user_select == "s")&(ai_select == "p")){
      user_score <- user_score + 1
      print("Your win")
    }else if((user_select == "p")&(ai_select == "h")){
      user_score <- user_score + 1
      print("Your win")
    }else if(user_select == ai_select){
      print("Tie")
    }else {
      ai_score <- ai_score + 1
      print("Ai win")
    }
  }

}
Pao_Ying_Chub_Game()
