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
- Show all albums with their respective artists
- Get total comments on licensed tracks
- Filter tracks from album type "single"
- Count number of tracks by each artist
- Calculate average danceability by album
- Get top 5 tracks with highest energy
- List official videos with total views and likes
- Calculate total views per album
- Compare Spotify vs YouTube streaming counts
- Top 3 most-viewed tracks per artist (using window functions)
- Tracks with above-average liveness
- Energy gap within albums (using CTE)
- Tracks with energy-to-liveness ratio > 1.2
- Cumulative likes ordered by views (window function)


