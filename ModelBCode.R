
cleanBfxn.fun <- function() {
  
  #Libaries to be declared
  library(stringr)
  
  #Read the required data from csv
  modelB = read.csv("modelB.csv")
  
  #Check if Twitter is Source of information : Score1 {0:False;1:True}
  temp_source <-
    substring(modelB$source, regexpr(">", modelB$source) + 1)
  temp_source = as.data.frame(temp_source)
  names(temp_source)[1] = 'source'
  labels <- vector("list")
  
  source_l <-
    cbind(str_sub(temp_source$source, 1, str_length(temp_source$source) - 4))
  source_l = as.data.frame(source_l)
  names(source_l)[1] = 'source'
  modelB$source <- source_l$source
  r = 1
  save_score1 <- vector("list")
  Score1 <- vector("list")
  for (i in modelB$source)
  {
    if (grepl("Twitter", i, fixed = TRUE))
      score1 = 1
    else
      score1 = 0
    labels$score1[r] <- score1
    modelB$Score1[r] <- score1
    r = r + 1
  }
  
  #Check the Listed count as a parameter : Score2 {}
  listed_count <- (boxplot.stats(modelB$listed_count))$stats
  out_listed <- (boxplot.stats(modelB$listed_count))$stats
  listed_count
  listed_count[5] #Upper Whiskers Value
  listed_count[3] #Median Value
  
  save_score2 <- vector("list")
  Score2 <- vector("list")
  j = 1
  for (i in modelB$listed_count)
  {
    if (i > listed_count[3] - 1 &&
        i < listed_count[5] + 1)
      #Score=1 : counts between median and upper whisker of boxplot
    {
      score2 = 3
      listed_score <- "high"
    }
    else
      if (i > listed_count[2] - 1 && i < listed_count[3] + 1)
      {
        score2 = 2
        listed_score <- "moderate"
      }
    #If value lies within upper hinge of boxplot of outliers then score=High else Low
    else if (i < out_listed[4] + 1 && i > listed_count[5])
    {
      score2 <- 3
      listed_score <- "high"
    }
    else
    {
      score2 <- 1
      listed_score <- "low"
    }
    labels$score2[j] <- score2
    modelB$Score2[j] <- listed_score
    j = j + 1
  }
  
  #Check if user is verified or not. : Score_v
  r = 1
  for (i in modelB$verified)
  {
    if (identical(i, TRUE))
      score_v = 1
    else
      score_v = 0
    labels$score3[r] <- score_v
    r = r + 1
  }
  
  #Check when Date of creation of account : Score4
  age_temp1 <-
    substring(modelB$user_created_at,
              regexpr("+0000", modelB$user_created_at) + 5)
  age_temp1 = type.convert(age_temp1, as.is = 'TRUE')
  age_temp1 = as.data.frame(age_temp1)
  names(age_temp1)[1] = 'user_created_at'
  modelB$user_created_at <- age_temp1$user_created_at
  r = 1
  Score4 <- vector("list")
  for (i in modelB$user_created_at)
  {
    if (i > 2013)
    {
      score4 = 1
      Age_score <- 'new'
    }
    else
      if (i > 2009 && i < 2014)
      {
        score4 = 2
        Age_score <- 'middle'
      }
    else
    {
      score4 = 3
      Age_score <- 'old'
    }
    modelB$Score4[r] <- Age_score
    labels$score_4[r] <- score4
    r = r + 1
  }
  
  #Check statues count : Score5
  stats_count <- (boxplot.stats(modelB$statuses_count))$stats
  stats_count
  stats_count[5] #Upper Whisker
  stats_count[3] #Median
  
  Score5 <- vector("list")
  j = 1
  for (i in modelB$statuses_count)
  {
    #Score=1 for counts between median and upper whisker of boxplot
    if (i > stats_count[3] - 1 && i < stats_count[5] + 1)
    {
      score5 = 3
      stat_score <- "high"
    }
    else if (i > stats_count[2] - 1 && i < stats_count[3] + 1)
    {
      score5 = 2
      stat_score <- "moderate"
    }
    else
    {
      score5 <- 1
      stat_score <- "low"
    }
    
    modelB$Score5[j] <- stat_score
    labels$score_5[j] <- score5
    j = j + 1
  }
  
  #Check followers and friend count : Ratio & Score6
  r = 1
  ratio <- vector("list")
  for (i in 1:nrow(modelB))
  {
    modelB$Ratio[r] = modelB$followers_count[r] / modelB$friends_count[r]
    r = r + 1
  }
  
  ratio_count <- (boxplot.stats(modelB$Ratio))$stats
  ratio_count
  ratio_count[5] #Upper Whisker
  ratio_count[3] #Median
  ratio_count[2] #Lower Hinge
  Score6 <- vector("list")
  j = 1
  for (i in modelB$Ratio)
  {
    #Score=1 for counts between median and upper whisker of boxplot
    if (i > ratio_count[3] && i < ratio_count[5])
    {
      score6 = 3
      ratio_score <- "high"
    }
    else if (i > ratio_count[2] && i < ratio_count[3])
    {
      score6 = 2
      ratio_score <- "moderate"
    }
    else
    {
      score6 <- 1
      ratio_score <- "low"
    }
    modelB$Score6[j] <- ratio_score
    labels$score_6[j] <- score6
    j = j + 1
  }
  
  #Check for credibility with verified account and Ratio : Score3
  r = 1
  Score3 <- vector("list")
  r = 1
  for (i in 1:nrow(modelB))
  {
    if ('TRUE' %in% modelB$verified[r])
    {
      if ('High' %in% labels$score_6[r])
        score3 = 4
      else
        score3 = 3
    }
    else
    {
      if ('Low' %in% labels$score_6[r])
        score3 = 1
      else
        score3 = 2
    }
    modelB$Score3[r] <- score3
    labels$score_3[r] <- score3
    r = r + 1
  }
  
  #Check credibility on basis of Verified + Ratio, Statuses Count and Listed Count : Score7
  foll_count <- boxplot(modelB$followers_count)$stats
  foll_count[3]
  foll_count[5]
  frnd_count <- boxplot(modelB$friends_count)$stats
  frnd_count[3]
  frnd_count[2]
  frnd_count[1]
  r = 1
  Score7 <- vector("list")
  for (i in 1:nrow(modelB))
  {
    if (modelB$Score3[r] == 4)
    {
      if ('low' %in% modelB$Score_5[r])
        score7 = 2
      else
        score7 = 3
    }
    else if (modelB$Score3[r] == 3)
    {
      if (modelB$followers_count[r] > foll_count[3] &&
          modelB$friends_count[r] > frnd_count[3])
        score7 = 3
      else if (modelB$followers_count[r] < foll_count[2] &&
               modelB$friends_count[r] < frnd_count[2])
        score7 = 2
    }
    else if (modelB$Score3[r] == 2)
    {
      if ('low' %in% modelB$Score5[r])
        score7 = 2
      else if ('mod' %in% modelB$Score5[r] ||
               'high' %in% modelB$Score5[r])
      {
        if ('mod' %in% modelB$Score2[r] || 'high' %in% modelB$Score2[r])
          score7 = 3
        else
          score7 = 1
      }
    }
    else
    {
      if ('low' %in% modelB$Score2[r])
      {
        if ('new' %in% modelB$Score4[r])
          score7 = 2
        else
          score7 = 1
      }
      else
        score7 = 2
    }
    
    modelB$Score7[r] <- score7
    r = r + 1
  }
  
  #Write the processed data in "modelB_P.csv" and into data frame modelB_P. Also, set "modelB.csv" straight.
  modelB <- modelB[, c(4, 9, 10, 15, 11, 12, 14, 16)]
  modelB_P <- modelB
  write.csv(modelB, file = "modelB_P.csv")
  
}