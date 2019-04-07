
cleanAfxn.fun <- function() {
  
  #Libaries to be declared
  library(stringr)
  library(base)
  library(gsubfn)
  library(proto)
  library(RSQLite)
  library(sqldf)
  
  #Read the required data from csv
  modelA = read.csv("modelA.csv")
  
  #Check for Linked URL : Url_linked {TRUE;FALSE}
  modelA$Url_linked <- str_detect(modelA$text, "http")
  
  #Check for Mention : Mentions {TRUE;FALSE}
  modelA$Mentions <- str_detect(modelA$text, "@")
  
  #Checks if it is a RT : RT {TRUE;FALSE}
  modelA$RT <- str_detect(modelA$text, 'RT @')
  
  #Checks number of Words : No_ofwords {More than 18;Between 11 and 18;Less than or equal to 10}+Nwords <-
  Nwords <- lengths(gregexpr("\\W+", modelA$text)) + 1
  No_ofwords <- as.data.frame(Nwords)
  
  Score4 <- vector("list")
  r = 1
  for (i in No_ofwords$Nwords)
  {
    if (i > 18)
      words_ans = "More than 18"
    else if (i > 10)
      words_ans = "Between 11 and 18"
    else
      words_ans = "Less than or equal to 10"
    
    modelA$No_ofwords[r] <- words_ans
    r = r + 1
  }
  
  #Count number of Hahtags("#") : Hashtags {Zero;One;Two or more}
  No_ofwords$Hashtags <- str_count(modelA$text, "#")
  
  Score5 <- vector("list")
  r = 1
  for (i in No_ofwords$Hashtags)
  {
    if (i > 1)
      hash_ans = "Two or more"
    else if (i == 1)
      hash_ans = "One"
    else
      hash_ans = "Zero"
    
    modelA$Hashtags[r] <- hash_ans
    r = r + 1
  }
  
  #Count number of charecters : No_ofchars {More than 135;Between 91 and 135;90 or lesser}
  Query1 <- sqldf("Select length(text) from modelA")
  Query1 <- as.data.frame(Query1)
  names(Query1)[1] <- 'char_count'
  No_ofwords$char_count <- Query1$char_count
  
  Score6 <- vector("list")
  r = 1
  for (i in No_ofwords$char_count)
  {
    if (i > 135)
      char_ans = "More than 135"
    else if (i > 90)
      char_ans = "Between 91 and 135"
    else
      char_ans = "90 or lesser"
    
    modelA$No_ofchars[r] <- char_ans
    r = r + 1
  }
  
  #Check presence of Comma : Comma {TRUE;FALSE}
  modelA$Comma <- str_detect(modelA$text, ",")
  
  #Check for Exclamation mark : Exclamations {TRUE;FALSE}
  modelA$Exclamations <- str_detect(modelA$text, "!")
  
  #Write the processed data in "modelA_P.csv" and into data frame modelA_P. Also, set "modelA.csv" straight.
  modelA <- modelA[, c(4, 5, 6, 7, 8, 9, 10, 11)]
  modelA_P <- modelA
  write.csv(modelA, file = "modelA_P.csv")
  
}
