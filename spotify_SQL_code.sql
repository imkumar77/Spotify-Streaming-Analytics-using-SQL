create database if not exists Spotify ;
use Spotify ;

-- create table
DROP TABLE IF EXISTS spotify;
-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed Varchar (10),
    official_video Varchar(10),
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- ------------------------EDA-------------------------------------------------------
ALTER TABLE spotify
MODIFY COLUMN Licensed VARCHAR(10);

ALTER TABLE spotify
MODIFY COLUMN official_video VARCHAR(10);

select  distinct album_type from spotify ;

select * from spotify;

/*
-- --------- Data Analysis--------------------------------------------------

Easy Level
Retrieve the names of all tracks that have more than 1 billion streams.
List all albums along with their respective artists.
Get the total number of comments for tracks where licensed = TRUE.
Find all tracks that belong to the album type single.
Count the total number of tracks by each artist.

*/
-- Retrieve the names of all tracks that have more than 1 billion streams.
select* from spotify 
where stream > 1000000000;

-- List all albums along with their respective artists.
select album, artist 
from spotify ;

-- Get the total number of comments for tracks where licensed = TRUE.
select sum(comments)
from spotify 
where licensed = 'true';

-- Find all tracks that belong to the album type single
select * from spotify 
where album_type = 'single' ;

-- Count the total number of tracks by each artist. 
select artist, count(*) as Total_num_song
from spotify
group by artist;

/*
-- ------------------------------------------------------------------------------------------------
Medium Level
Calculate the average danceability of tracks in each album.
Find the top 5 tracks with the highest energy values.
List all tracks along with their views and likes where official_video = TRUE.
For each album, calculate the total views of all associated tracks.
Retrieve the track names that have been streamed on Spotify more than YouTube.
*/

-- Calculate the average danceability of tracks in each album.
select album, avg(danceability) as avg_danceability from spotify
group by 1 
order by avg_danceability desc;

-- Find the top 5 tracks with the highest energy values.
select 
track, 
max(energy) as energy_level
 from spotify 
 group by track
 order by energy_level desc
 limit 5 ;

-- List all tracks along with their views and likes where official_video = TRUE.
select
track, 
sum(views) as Total_views ,
sum( likes) as Total_likes
 from spotify 
 where official_video = 'TRUE'
 group by track ;
 
 -- For each album, calculate the total views of all associated tracks.
 select 
  album ,
 Track,
 sum(views) as Total_views
 from spotify
 group by  1, 2 ;
 
 -- Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT 
    track,
    most_played_on,
    stream 
FROM spotify 
WHERE most_played_on IN ('youtube', 'spotify');

SELECT 
    track AS track_name,
    COALESCE(SUM(CASE WHEN most_played_on = 'youtube' THEN stream END), 0) AS stream_on_youtube,
    COALESCE(SUM(CASE WHEN most_played_on = 'spotify' THEN stream END), 0) AS stream_on_spotify
FROM spotify
GROUP BY track;


/*
-- -------------------------------------------------------------------------------------------------------------------------------
Find the top 3 most-viewed tracks for each artist using window functions.
Write a query to find tracks where the liveness score is above the average.
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

*/
-- Find the top 3 most-viewed tracks for each artist using window functions.

WITH ranking_artist AS (
    SELECT 
        artist,
        track,
        SUM(views) AS total_view,
        DENSE_RANK() OVER (PARTITION BY artist ORDER BY SUM(views) DESC) AS R1
    FROM spotify
    GROUP BY artist, track
)
SELECT * FROM ranking_artist ;

-- Write a query to find tracks where the liveness score is above the average.
select * from spotify ;

select track,
artist,
 liveness
 from spotify
 where liveness>(
 select avg(liveness) from spotify) ;


-- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

WITH cte
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY 2 DESC ;


-- Find tracks where the energy-to-liveness ratio is greater than 1.2

select * from spotify ;
select track,
energy,
liveness,
liveness/ energy as energy_to_liveness_ratio
from spotify
where liveness/ energy >1.2;

-- Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
SELECT 
    track,
    artist,
    views,
    likes,
    SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify;





