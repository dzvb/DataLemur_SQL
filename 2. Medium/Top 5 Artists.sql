-- Assume there are three Spotify tables: artists, songs, and global_song_rank, which contain information about the artists, songs, and music charts, respectively.

-- Write a query to find the top 5 artists whose songs appear most frequently in the Top 10 of the global_song_rank table. Display the top 5 artist names in ascending order, along with their song appearance ranking.

-- If two or more artists have the same number of song appearances, they should be assigned the same ranking, and the rank numbers should be continuous (i.e. 1, 2, 2, 3, 4, 5).

WITH artist_counts AS (
  SELECT
    g.song_id,
    s.artist_id,
    a.artist_name
  FROM
    global_song_rank g
  INNER JOIN
    songs s
  ON
    g.song_id = s.song_id
  INNER JOIN
    artists a
  ON
    s.artist_id = a.artist_id
  WHERE
    g.rank <= 10
),

top_artists AS (
  SELECT
    artist_name,
    COUNT(*) AS n_appearances
  FROM
    artist_counts
  GROUP BY
    artist_name
),

rankings AS (
  SELECT
    artist_name,
    n_appearances,
    DENSE_RANK() OVER(ORDER BY n_appearances DESC) AS artist_rank
  FROM
    top_artists
)

SELECT
  artist_name,
  artist_rank
FROM
  rankings
WHERE
  artist_rank <= 5
ORDER BY
  artist_rank