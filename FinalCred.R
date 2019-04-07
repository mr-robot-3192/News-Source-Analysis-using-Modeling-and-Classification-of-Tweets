

credibility.fxn <- function() {
  
  #Final Credibility calculations.
  r=1
  for (i in 1:nrow(modelF))
  {
    if ('HC' %in% modelF$Tweet_Credibility[r])
    {
      if ('HC' %in% modelF$Tweeter_Credibility[r])
        modelF$Credibility[r] <- 'VHC'
      else if ('NC' %in% modelF$Tweeter_Credibility[r])
        modelF$Credibility[r] <- 'HC'
      else
        modelF$Credibility[r] <- 'NC'
    }
    else if ('NC' %in% modelF$Tweet_Credibility[r])
    {
      if ('HC' %in% modelF$Tweeter_Credibility[r])
        modelF$Credibility[r] <- 'HC'
      else if ('NC' %in% modelF$Tweeter_Credibility[r])
        modelF$Credibility[r] <- 'NC'
      else
        modelF$Credibility[r] <- 'LC'
    }
    else
    {
      if ('HC' %in% modelF$Tweeter_Credibility[r])
        modelF$Credibility[r] <- 'NC'
      else if ('NC' %in% modelF$Tweeter_Credibility[r])
        modelF$Credibility[r] <- 'LC'
      else
        modelF$Credibility[r] <- 'VLC'
    }
    r = r + 1
  }
  write.csv(modelF,"Final.csv")
  
}