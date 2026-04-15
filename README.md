# Movie Rating Analysis System

This is my favorite project right now. hope I've explained why thought process toward building this system. Database project for implementing Problem Statement: Movie Recommendation and Rating Analysis System. Since i've designed a Movie recommendation system before, I've used it as a base. I have split the listed functions into 4 categories. 

Reason why I did this in the past is because I have always been recommend movies that I dislike. This is because the users are plotted together based on fewer parameters. 

When plotting users usually done by averaging multiple parameters like watch time, rating etc into once single number that tells how similar users are.

My plan idea is to seperate each parameters. eg: in watch time user x is similar to user y, in terms of rating they are similar to z. and finally we consolidate this into an number to determine the recommendation.

Eg: User 1 watches a lot of Sci-fi movies, but he rates them lower in this regard he is similar to User 2. But User 1 rated a movie 4 and User 2 rated it 2. is there a similar pair who did this? Find all the pair of users who rated similarly. What movie do they all agree is good? Recommend the movie. 

### Movie rating system: Challenges 

- users can watch a movie and not rate 
- User who dont want enough movies
- users who watch one movie and then give rating

There isnt simply people who rate movies. in all of these cases we cannot recommend a movie properly.
They main issue is people rate movies because of the hype surrounding it rather that what the movie actually is. To solve this we need:

This leads us to Recomendation analysis based on user behaviour:

### Behavior Analysis system:

- Find the closest neighbor and then consolidate a sample set of 20 users for example. Perform analyse for specific movie everyone agrees is good that the User x did not watch. Do this for a bunch of different attributes like eg: watch time, similar users who have watched a movie completely and compare with a set. 

- I analyse users based on their rating style too. I split users based on rating and ratings based on users.

Ratings <--> Users 

- some people rate movies higher frequenly and some rate it lower in general. We can determine if a person enjoyed the movie based on this.

## SQL Files

### sql
schema.sql
sample_data.sql
0analysis_queries.sql

## setup

make sure you have sql installed

```bash
mysql -e "CREATE DATABASE movie_rating_analysis;"

mysql movie_rating_analysis < schema.sql
mysql movie_rating_analysis < sample_data.sql
mysql movie_rating_analysis < analysis_queries.sql
```

##  queries:

**Query 1: top movies**
lists best-rated titles with at least 2 ratings mut be there

**Query 2: popular genres**
shows total watches,  viewers, and average completion time by genre.

**Query 3: recommendations**
combines rating pattern neighbors and genre affinity neighbors into one ranked recommendation list and shows which users were selected as neighbors for each recommendation dimension.

also I have only used 2 dimensions or attributes in this project

**Query 4: trending movies**
finds movies with recent watch activity (last 7 days) and shows average ratings.

