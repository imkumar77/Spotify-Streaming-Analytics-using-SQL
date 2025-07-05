# Spotify-Streaming-Analytics-using-SQL
  ![Spotify_logo](https://github.com/user-attachments/assets/7ba0049c-e639-45f5-a54b-310b58d3f8e0)

## Description
This project explores and analyzes a Spotify music dataset using SQL. The dataset includes information about tracks, artists, albums, streaming platforms, and audio features such as energy, danceability, and valence. The main objective is to demonstrate the ability to write and optimize SQL queries that extract meaningful insights from real-world-like data. Queries are organized into three levels — easy, medium, and advanced — and showcase skills in:

- Data exploration and filtering

- Aggregations and grouping

- Use of Common Table Expressions (CTEs)

- Window functions for ranking and cumulative analysis

- Performance tuning using EXPLAIN and indexing

This project highlights how SQL can be used not just for querying data, but also for drawing conclusions about music performance, user engagement, and platform-based trends (e.g., Spotify vs YouTube).

---
## Dataset Overview
Data : Spotify_Dataset.csv

You can get this Data set from Kaggle : https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset

The data includes the following columns:

- **artist, track, album, album_type**
- **danceability, energy, loudness, speechiness, acousticness, instrumentalness, liveness, valence, tempo**
- **duration_min, title, channel**
- **views, likes, comments, licensed, official_video, stream, most_played_on**
- **energy_liveness** (derived column: energy * liveness)

## Database Setup

```sql
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
    licensed boolean ,
    official_video boolean,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
```

---

### 1️ Database Setup
- Created a MySQL database named `Spotify`.
- Defined the `spotify` table to store track-level data with columns for artist, album, audio features (e.g., energy, liveness), and user engagement (e.g., views, likes, comments).

### 2️ Data Cleaning & Preparation
- Modified data types for boolean-like columns (`licensed`, `official_video`) for consistency.
- Ensured correct structure for attributes like `album_type`, `most_played_on`, and numeric columns for analysis.

### 3️ Exploratory Data Analysis (EDA)
- Inspected distinct album types and initial rows of the dataset.
- Verified data distribution across categories and validated presence of key attributes.

### 4️ Querying the Data
- Wrote SQL queries grouped into three difficulty levels:

### 5 Analysis Objectives

- List all tracks with more than 1B streams
```sql
select* from spotify 
where stream > 1000000000;
  ```
- Show all albums with their respective artists
```sql
  select album, artist 
from spotify ;
```

- Get total comments on licensed tracks = True
```sql
select sum(comments)
from spotify 
where licensed = 'true';
```

- Filter tracks from album type "single"
``` sql
select * from spotify 
where album_type = 'single' ;
```

- Count number of tracks by each artist
``` sql
select artist, count(*) as Total_num_song
from spotify
group by artist;
```

- Calculate average danceability by album
```sql
select album, avg(danceability) as avg_danceability from spotify
group by 1 
order by avg_danceability desc;
```

- Get top 5 tracks with highest energy
```sql
select 
track, 
max(energy) as energy_level
 from spotify 
 group by track
 order by energy_level desc
 limit 5 ;
```


- List official videos with total views and likes
```sql
select
track, 
sum(views) as Total_views ,
sum( likes) as Total_likes
 from spotify 
 where official_video = 'TRUE'
 group by track ;
```

- Calculate total views per album
```sql
 select 
  album ,
 Track,
 sum(views) as Total_views
 from spotify
 group by  1, 2 ;
```
- Compare Spotify vs YouTube streaming counts
```sql
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
```

- Top 3 most-viewed tracks per artist (using window functions)
```sql
WITH ranking_artist AS (
    SELECT 
        artist,
        track,
        SUM(views) AS total_view,
        DENSE_RANK() OVER (PARTITION BY artist ORDER BY SUM(views) DESC) AS R1
    FROM spotify
    GROUP BY artist, track
)
```

- Tracks with above-average liveness
```sql
select track,
artist,
 liveness
 from spotify
 where liveness>(
 select avg(liveness) from spotify) ;
```

- Energy gap within albums (using CTE)
```sql
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
```

- Tracks with energy-to-liveness ratio > 1.2
```sql
select * from spotify ;
select track,
energy,
liveness,
liveness/ energy as energy_to_liveness_ratio
from spotify
where liveness/ energy >1.2;
```

- Cumulative likes ordered by views (window function)
```sql
select * from spotify ;
select track,
energy,
liveness,
liveness/ energy as energy_to_liveness_ratio
from spotify
where liveness/ energy >1.2;
```


