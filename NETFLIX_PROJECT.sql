CREATE DATABASE Netflix_Analysis;
USE Netflix_Analysis;

CREATE TABLE Netflix_Originals (
  Title VARCHAR(1000),
  GenreID VARCHAR(100),
  Runtime INT,
  IMDBScore DECIMAL(3,1),
  Language VARCHAR(100),
  Premiere_Date DATE
);
SELECT * FROM Netflix_Originals;

CREATE TABLE Genre_Details (
  GenreID VARCHAR(100),
  GenreName VARCHAR(100)
);
SELECT * FROM Genre_Details;

-- 1.What are the average IMDb scores for each genre of Netflix Originals?
SELECT G.Genre, ROUND(AVG(N.IMDBScore),2) AS AVG_IMDB_SCORE
FROM Netflix_Originals AS N
JOIN Genre_Details AS G ON N.GenreID = G.GenreID
GROUP BY Genre
ORDER BY AVG_IMDB_SCORE;

-- 2.Which genres have an average IMDb score higher than 7.5?
SELECT G.Genre, ROUND(AVG(N.IMDBScore),2) AS AVG_IMDB_SCORE
FROM Netflix_Originals AS N
JOIN Genre_Details AS G ON N.GenreID = G.GenreID 
GROUP BY Genre
HAVING AVG(IMDBScore) > 7.5;

-- 3.List Netflix Original titles in descending order of their IMDb scores.
SELECT Title, IMDBScore 
FROM Netflix_Originals
ORDER BY IMDBScore DESC;

-- 4.Retrieve the top 10 longest Netflix Originals by runtime.
SELECT Title, Runtime 
FROM Netflix_Originals 
ORDER BY Runtime DESC
LIMIT 10;

-- 5.Retrieve the titles of Netflix Originals along with their respective genres.
SELECT N.Title, G.Genre
FROM Netflix_Originals AS N
JOIN Genre_Details AS G ON N.GenreId = G.GenreID;

-- 6.Rank Netflix Originals based on their IMDb scores within each genre.
SELECT N.Title, G.Genre, N.IMDBScore,
RANK() over(PARTITION BY G.Genre ORDER BY N.IMDBscore DESC) AS RANK_IN_GENRE
FROM  Netflix_Originals AS N
JOIN Genre_Details AS G ON N.GenreId = G.GenreID;

-- 7.Which Netflix Originals have IMDb scores higher than the average IMDb score of all titles?
SELECT Title,IMDBScore
FROM netflix_originals
WHERE IMDBScore > (SELECT AVG(IMDBScore) FROM netflix_originals)
ORDER BY IMDBScore DESC;

-- 8.How many Netflix Originals are there in each genre?
SELECT G.Genre, Count(*) AS Total_Titles
FROM Netflix_Originals AS N 
JOIN Genre_Details AS G On N.GenreID = G.GenreID
GROUP BY Genre;  

-- 9.Which genres have more than 5 Netflix Originals with an IMDb score higher than 8?
SELECT G.Genre, count(*) AS Titles
FROM netflix_originals AS N
JOIN Genre_Details AS G ON N.GenreID = G.GenreID
WHERE N.IMDBScore > 8
GROUP by G.genre
HAVING COUNT(*)>5;

-- 10.What are the top 3 genres with the highest average IMDb scores, and how many Netflix Originals do they have?
SELECT G.Genre, ROUND(AVG(N.IMDBScore),2) AS AVG_IMDB_Score, COUNT(*) AS Total_Titles
FROM Netflix_Originals AS N
JOIN Genre_Details AS G ON N.GenreID = G.GenreID
GROUP BY G.Genre
ORDER BY AVG_IMDB_Score DESC
LIMIT 3;	