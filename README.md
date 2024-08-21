# MovieDataBaseApp

1. List out the below options to show related movies:
* Year
* Genre
* Directors
* Actors
* All Movies
On tapping of each option, list out the values linked to it on the same screen (expand/collapse) effect. 
- In case of "Year/Genre/Directors/Actors", only one field is required to show in each value cell
- In case of "All Movies", thumbnail, movie title, language and year fields required to show in each value cell

For example, if Genre contains Comedy, Action, Sport then show them as separate values. On clicking each value, display a list of movies associated with that value. This example is applicable to all options listed above.

2. Search: User can search for movies by title/genre/actor/director. For example, if user searches for “comedy”, then display all movies which contains “comedy” in title/genre/actor/director. 
 
On search, UI will show a list of movies that are matched and on clearing search UI will show list of options mentioned above. (year/genre/directors/actors). Each movie index cell should display poster, title, language, year.
 
3. On tapping the movie, show the details:
* Poster, title, plot, cast & crew, released date, genre and rating
* User should be able to select a rating source (IMDB, Rotten Tomatoes, Metacritic) to see the rating value. 
* Create a custom UI control to show rating value.
* 
Fetching All details from local json file.
