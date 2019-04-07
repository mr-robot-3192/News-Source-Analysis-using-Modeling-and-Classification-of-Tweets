
FetchandParse.fun <- function(Tags) {
  
  #Search for Tweets.
  filterStream(
    file.name = "tweets.json",
    track = Tags,
    tweets = 500,
    oauth = credential,
    timeout = 200,
    lang = 'en'
  )
  
  #Parse tweets and create data frames {modelA,modelB} and CSV {"data.csv";"modelA.csv";"modelB.csv"}
  tweet_df <- parseTweets(tweets = 'tweets.json')
  write.csv(tweet_df, file = 'data.csv')
  modelA <- tweet_df[, c('text', 'id_str')]
  write.csv(modelA, file = 'modelA.csv')
  modelB <-
    tweet_df[, c(
      'source',
      'listed_count',
      'verified',
      'user_created_at',
      'statuses_count',
      'followers_count',
      'friends_count'
    )]
  write.csv(modelB, file = 'modelB.csv')
  
}
