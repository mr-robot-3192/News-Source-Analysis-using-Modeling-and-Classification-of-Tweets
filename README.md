# News-Source-Analysis-using-Modeling-and-Classification-of-Tweets

# Introduction
  * In recent times, social media is one of the major ways by which people access news and information.
  * However, information that passes through tweets is not verifiable during real time. Thus, there is a lot of scope for spreading of misinformation and bogus news.
  * This project will analyse tweets for their credibility so that content can be both accessible and correct at the same time.
  * Categorize the content of tweets into :
    * Very high credibility
    * High Credibility
    * Neutral Credibility
    * Low Credibility
    * Very Low Credibility
  * Perform two tasks: User Classification and Tweet Classification to determine Content Credibility:
   
    * User | H | H | H | N | N | N | L | L | L 
      --- | --- | --- | --- |--- |--- |--- |--- |--- |---
      Tweet | H | N | L | H | N | L | H | N | L 
      Content | VH | H | N | H | N | L | N | L | VL
      
# Sample of Data and Preprocessing steps:
 
  * ![alt text](https://user-images.githubusercontent.com/25413110/55702487-95333c80-598b-11e9-8a66-ffe37c25114c.png)
 
# Parameters

* **User Parameters:**

Based on our literature survey, we chose the following parameters for determining user credibility:
  
    1. Source: The source from where the tweet was published
    2. Listed count: The number of public lists that a user is a part of
    3. Verified: Indicates if a user has been verified by Twitter
    4. Account age: The age of an account in years
    5. Statuses count: The number of statuses posted by the user
    6. Followers to friends ratio: The number of followers to friends for a Twitter user

* **Tweet Parameters:**

The Twitter API enables us to gather 42 parameters for a tweet. However, all parameters cannot be used for classification of tweets into categories as:
   * The classes may be imbalanced or
   * The parameters may not give any information
   
Therefore, we selected features based on past papers and our experience on Twitter as users:

    1. Tweet_ID: Identifier of the tweet (represented as T_ID)
    2. URL_Linked: Indicates if a tweet contains a hyperlink or not
    3. RT: Indicates if a user is choosing to retweet someone else’s tweet and quoting it
    4. Number of words in the tweet
    5. Number of hashtags in the tweet
    6. Number of characters
    7. Comma which states if a tweet contains a comma or not
    8. Exclamation which states if a tweet contains an exclamation mark or not
    9. Mentions which indicates if that tweet contains a reference to another twitter user

# Algorithm

  * The problem of categorization was multiclass classification and not binary classification, we chose the following 3 algorithms to help us in building a model:
  
     * Multinomial Logistical Regression
     * Sequential Minimal Optimization
     * Random Forest
  * For creating a model, we used WEKA, and 2 methods of testing:
     * Complete Test Data
     * 10-fold cross validation 
  * We found out that though Random Forest had the highest accuracy when all these testing methods were combined, multinomial logistical regression had took the least time with almost the same accuracy. Therefore, we chose Multinomial Logistic Regression for the categorization.

# Implementation

  * Establishing connection with Twitter API
```
AuthandHandshake.fun(
                      Establish Handshake with ”https://api.twitter.com/”
                      Enter your twitter credentials and authorize the application
                      On sucessful authentication R redirects you to browser, enter the 6 digit pin from browser on R Console
                    )
```

  * Fetch and Parse Tweets on required Hashtag 
```
FetchandParse.fun(Tags)(
                         Search for Tweets.
                         Parse tweets and create data frames and CSV.
                       )

```
  * Clean the Data and generate required paramters for Tweet Content Credibility Processing
```
cleanAfxn.fun(
               Read the required data from csv
               Check for Linked URL : Url_linked
               Check for Mention : Mentions
               Checks if it is a RT : RT
               Checks number of Words : No_ofwords
               Count number of Hahtags(” ”) : Hashtags
               Count number of charecters : No_ofchars
               Check presence of Comma : Comma 
               Check for Exclamation mark : Exclamations
               Write the processed data in CSV and into data frame
             )
```
  * Clean the Data and generate required paramters for User Credibility Processing
```
cleanBfxn.fun(
               Read the required data from csv
               Check if Twitter is Source of information : Score1
               Check the Listed count as a parameter : Score2
               Check if user is verified or not. : Score_v
               Check when Date of creation of account : Score4
               Check statues count : Score5
               Check followers and friend count : Ratio & Score6
               Check for credibility with verified account and Ratio : Score3
               Check credibility on basis of Verified + Ratio, Statuses Count and Listed
               Count : Score7
               Write the processed data in CSV and into data frame.
             )
```
  * Calculate Tweet Credibility.
```
modelAfxn.fun(
               Read the required data from csv
               Inputs to Train the machine.
               Train the machine as ModelA_T
               Stats of the Model
               Run the model for new set.
               Read the required data from csv
               Get credibility for new Dataset.
               Record the Credibility and write it into csv.
             )
```

  * Calculate Tweeter Credibility.
```
modelBfxn.fun(
               Read the required data from csv
               Inputs to Train the machine.
               Train the machine as ModelB_T
               Stats of the Model
               Run the model for new set
               Read the required data from csv
               Get credibility for new Dataset.
               Record the Credibility and write it into csv.
             )
```  
  * Calculate Final Credibility.
```
credibility.fxn(
                 Final Credibility calculations.
                 Write final scores into CSV
               )
```
  * Output System as a R application

   1. Define UI for application.
```
ui <- fluidPage(
                 Application title
                 Sidebar with Inputs
                 Sidebar Panel for inputs
                 Input: Selector for choosing dataset
                 Input: Number of obs
                 Main panel for displaying outputs
               )
```

   2. Define Server Logic
```
server <- function(input, output)
Return the requested dataset.
Show the first ”n” observations.
```
   3. Run the application
```
shinyApp(ui = ui, server = server)
```

# Output

  * ![alt text](https://user-images.githubusercontent.com/25413110/55706007-f6134280-5994-11e9-9112-11f4611503e7.jpg)
 
 
