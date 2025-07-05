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
Data : 

The data includes the following columns:

- **artist, track, album, album_type**
- **danceability, energy, loudness, speechiness, acousticness, instrumentalness, liveness, valence, tempo**
- **duration_min, title, channel**
- **views, likes, comments, licensed, official_video, stream, most_played_on**
- **energy_liveness** (derived column: energy * liveness)
