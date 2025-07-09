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
SELECT 
    track,
    artist,
    views,
    likes,
    SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify;
```

### 6 Query Optimization
- Analyzed performance of queries using `EXPLAIN`.
- Created an index on the `artist` column to improve query speed.
- Re-ran the same query to compare execution and planning times before and after optimization.

### 7 Key SQL Concepts Used

- Data filtering with WHERE and LIKE
- Aggregations with SUM(), COUNT(), AVG()
- Grouping and sorting using GROUP BY and ORDER BY
- Window functions: RANK(), SUM() OVER
- Common Table Expressions (CTEs) using WITH
- Query optimization with EXPLAIN and indexing

### 8 Tools & Technologies

| Tool                | Purpose                           |
| ------------------- | --------------------------------- |
| MySQL               | Data storage and querying         |
| SQL Functions       | Aggregation, Filtering, Windowing |
| CTEs & Views        | Structuring complex queries       |
| Workbench / DBeaver | SQL IDE for development           |

---

## Insights & Findings

The SQL analysis of Spotify track data led to several valuable insights:

- **High-Streaming Tracks**: A small group of tracks surpassed 1 billion streams, indicating strong user preference and repeat play behavior.

-  **Artist Productivity**: Certain artists have released a significantly higher number of tracks, reflecting either high productivity or multiple versions (live, remixes, etc.).

- **Album Type Trends**: "Single" type albums dominate the dataset, which aligns with current music release strategies in streaming culture.

- **User Engagement**: Licensed tracks received significantly more comments, suggesting a correlation between licensing and user interaction.

- **Top Energy Tracks**: The top 5 most energetic tracks may be well-suited for high-activity playlists like workouts or parties.

- **Official Videos Perform Better**: Tracks with `official_video = TRUE` have noticeably higher views and likes, underlining the impact of visual content on music engagement.

- **Spotify vs YouTube Trends**: Platform-specific popularity varies — some tracks are streamed more on YouTube, while others perform better on Spotify, hinting at demographic or format-based preferences.

- **Danceability Averages**: Some albums consistently score higher in danceability, useful for recommending upbeat, rhythmic playlists.

- **Energy Variance in Albums**: Using CTEs, you identified albums with the widest energy range, useful for albums that offer a "journey" rather than a uniform sound.

- **Liveness & Energy Ratios**: Tracks with a high energy-to-liveness ratio may simulate a "live performance" vibe, even if not recorded live.

- **Cumulative Engagement**: Cumulative likes by views revealed patterns in early engagement vs long-term popularity growth.

- **Performance Optimization**: By creating an index on the `artist` column, query performance was drastically improved — reducing execution time from ~7ms to ~0.15ms.

---

##  Conclusion

This project demonstrated how SQL can be a powerful tool for exploring, analyzing, and optimizing real-world datasets — in this case, Spotify track-level music data. By writing progressively complex queries, we uncovered insights into artist popularity, listener behavior, platform trends, and audio characteristics.

Through the use of advanced SQL techniques such as window functions, CTEs, and indexing, the project also highlighted the importance of efficient query structuring and performance tuning. These insights not only provide business value for music platforms and curators but also reflect strong data analysis and problem-solving skills.

The project serves as a complete example of turning raw, denormalized data into actionable insights using structured query language — a valuable skill in any data-driven role.

---

## License

This project is licensed under the MIT License.




