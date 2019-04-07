
AuthandHandshake.fun <- function() {
  
  #Installing Packages
  install.packages(c("ROAuth", "streamR", "rjson", "RCurl", "bitops"))
  
  #Library Packages
  library(ROAuth)
  library(bitops)
  library(rjson)
  library(RCurl)
  library(streamR)
  
  #Establish Handshake with "https://api.twitter.com/".
  credential <-
    OAuthFactory$new(
      consumerKey = '',
      consumerSecret = '',
      requestURL = 'https://api.twitter.com/oauth/request_token',
      accessURL = 'https://api.twitter.com/oauth/access_token',
      authURL = 'https://api.twitter.com/oauth/authorize'
    )
  
  options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
  download.file(url = "http://curl.haxx.se/ca/cacert.pem", destfile = "cacert.pem")
  #Enter your twitter credentials and authorize the application.
  #On sucessful authentication R redirects you to browser, enter the 6 digit pin from browser on R Console.
  credential$handshake(cainfo = "cacert.pem")
  
}