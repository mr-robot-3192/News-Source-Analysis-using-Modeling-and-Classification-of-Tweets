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
 * Sample of Data and Preprocessing steps:
 
 ![alt text](https://user-images.githubusercontent.com/25413110/55702487-95333c80-598b-11e9-8a66-ffe37c25114c.png)
  
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
