
SELECT 
    m.movie_id, 
    m.title, 
    m.genre, 
    round(avg(r.rating), 2) as avg_rating 
FROM movies m 
JOIN ratings r ON r.movie_id = m.movie_id 
GROUP BY m.movie_id, m.title, m.genre 
ORDER BY avg_rating DESC, m.title;


select 
    m.genre, 
    count(*) as total_watches, 
    count(distinct wh.user_id) as unique_viewers 
from watch_history wh 
join movies m on m.movie_id = wh.movie_id 
group by m.genre 
order by total_watches desc, m.genre;


SELECT m.movie_id, m.title, m.genre, ROUND(AVG(r.rating), 2) as avg_rating 
FROM movies m 
JOIN ratings r ON r.movie_id = m.movie_id 
WHERE m.genre IN (
    SELECT DISTINCT m2.genre 
    FROM watch_history wh2 
    JOIN movies m2 ON m2.movie_id = wh2.movie_id 
    WHERE wh2.user_id = 1
) 
AND m.movie_id NOT IN (
    SELECT movie_id FROM watch_history WHERE user_id = 1
) 
GROUP BY m.movie_id, m.title, m.genre 
ORDER BY avg_rating DESC, m.title 
LIMIT 5;

select u.user_id, u.name, count(*) as common_genre_watches 
from watch_history wh 
join users u on u.user_id = wh.user_id 
join movies m on m.movie_id = wh.movie_id 
where wh.user_id <> 1 
and m.genre in (
    select distinct m2.genre 
    from watch_history wh2 
    join movies m2 on m2.movie_id = wh2.movie_id 
    where wh2.user_id = 1
) 
group by u.user_id, u.name 
order by common_genre_watches desc, u.user_id 
limit 10;


SELECT m.movie_id, m.title, m.genre, count(*) as watches_last_7d 
FROM watch_history wh 
JOIN movies m ON m.movie_id = wh.movie_id 
WHERE wh.watch_date >= current_date - interval 7 day 
GROUP BY m.movie_id, m.title, m.genre 
ORDER BY watches_last_7d DESC, m.title;
