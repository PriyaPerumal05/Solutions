-- ProblemSet<Problem Set3>, November <30> <2017> 
-- Submission by <priya.a.perumal@accenture.com>


/*1.Find the titles of all movies directed by Steven Spielberg. (1 point possible)*/

select title from Movie where director='Steven Spielberg';


/*2.Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. (1 point possible)*/

select year from Movie m join Rating r on m.mID=r.mID where stars=4 or stars=5 order by year;


/*3.Find the titles of all movies that have no ratings. (1 point possible)*/

select title from Movie where mID not in(select mID from Rating);



/*4.Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. (1 point possible)*/

select name from Reviewer re join Rating ra on re.rID=ra.rID where ratingDate is null;


/*5.Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. (1 point possible)*/

select re.name,m.title,ra.stars,ra.ratingDate from Reviewer re join Rating ra on re.rID=ra.rID join Movie m on ra.mID=m.mID order by re.name,m.title,ra.stars; 



/*6.For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. (1 point possible)*/

select name, title from Reviewer, Movie, Rating, Rating r2 where Rating.mID=Movie.mID and Reviewer.rID=Rating.rID  and Rating.rID = r2.rID and r2.mID = Movie.mID  and Rating.stars < r2.stars and Rating.ratingDate < r2.ratingDate; 


/*7.For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title. (1 point possible)*/

select m.title,max(r.stars) from Movie m join Rating r on m.mID=r.mID group by r.mID order by m.title;



/*8.For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. (1 point possible)*/

 select m.mID,m.title,max(r.stars)-min(r.stars) as rating_spread from Movie m join Rating r on m.mID=r.mID group by m.mID order by rating_spread,m.title;



/*9.Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) (1 point possible)*/

SELECT AVG(b.stars)-AVG(a.stars) 
 FROM 
 ( 
 SELECT stars 
 FROM 
 ( 
 SELECT Rating.mID,AVG(Rating.stars) AS stars 
 FROM Rating 
 GROUP BY mID 
 ) AS sub1,Movie 
 WHERE sub1.mID=Movie.mID AND Movie.year<'1980' 
 ) as b, 
 ( 
 SELECT stars 
 FROM 
 ( 
 SELECT Rating.mID,AVG(Rating.stars) AS stars 
 FROM Rating 
 GROUP BY mID 
 ) AS sub2,Movie 
 WHERE sub2.mID=Movie.mID AND Movie.year>'1980' 
 ) as a; 

 
 
/*10.Find the names of all reviewers who rated Gone with the Wind. (1 point possible)*/

select rt.rID,name from reviewer r join rating rt on r.rID=rt.rID join movie m on m.mID=rt.mID where title='Gone with the Wind'; 



/*11.For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars. (1 point possible)*/

select r.name,m.title,rt.stars from Reviewer r join Rating rt on r.rID=rID join Movie m on rt.mID=m.mID where m.director=r.name;


/*12.Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".) (1 point possible)*/

select name,title from reviewer r join rating rt on r.rID=rt.rID join movie m on m.mID=rt.mID order by name,title; 


/*13.Find the titles of all movies not reviewed by Chris Jackson. (1 point possible)*/

select title from Movie where mID not in (select mID from Rating where rID in (select rID from Reviewer where name = "Chris Jackson") );


/*14.For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order. (1 point possible)*/

select distinct Re1.name, Re2.name
 from Rating R1, Rating R2, Reviewer Re1, Reviewer Re2 
where R1.mID = R2.mID
 and R1.rID = Re1.rID
 and R2.rID = Re2.rID 
and Re1.name < Re2.name 

order by Re1.name, Re2.name;

/*15.For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars. (1 point possible)*/

select r.name,m.title,min(rt.stars) from Reviewer r join Rating rt on r.rID=rt.rID join Movie m on rt.mID=m.mID group by m.mID;


 /*16.List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order. (1 point possible)*/

select m.title,avg(r.stars) from Movie m join Rating r on m.mID=r.mID group by m.mID order by m.title;


/*17.Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.) (1 point possible)*/


select name from Rating rt join Reviewer r on rt.rID=r.rID group by rt.rID having count(rt.rID) >= 3;


/*18.Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) (1 point possible)*/

select title,director from Movie  where director in (select director from Movie group by director having count(director) >= 2) order by director, title;


/*19.Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) (1 point possible)*/

select m.title, avg(r.stars) as strs from Rating r
join Movie m on m.mid = r.mid group by r.mid
having strs = (select max(s.stars) as stars from (select mid, avg(stars) as stars from rating
group by mid) as s)

/*20.Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.) (1 point possible)*/

select m.title, avg(r.stars) as strs from Rating r
join Movie m on m.mid = r.mid group by r.mid
having strs = (select min(s.stars) as stars from (select mid, avg(stars) as stars from rating
group by mid) as s)

/*21.For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. (1 point possible)*/

select director ,title from movie m join rating rt on m.mID=rt.mID and director is not NULL group by director  order by max(stars);







