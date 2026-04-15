--top rated movies
select m.movie_id, m.title, m.genre, round(avg(r.rating), 2) as avg_rating, count(*) as rating_count from ratings r join movies m on m.movie_id = r.movie_id group by m.movie_id, m.title, m.genre having count(*) >= 2 order by avg_rating desc, rating_count desc, m.title;

--popular genres
select m.genre, count(*) as total_watches, count(distinct wh.user_id) as unique_viewers, round(avg(wh.watch_duration_minutes * 1.0 / m.runtime_minutes) * 100, 1) as avg_completion_pct from watch_history wh join movies m on m.movie_id = wh.movie_id group by m.genre order by total_watches desc, unique_viewers desc, m.genre;

-- rating and genre dimensions collaboration
with params as (select 1 as target_user_id), target_seen as (select movie_id from ratings where user_id = (select target_user_id from params)), target_genres as (select distinct m.genre from watch_history wh join movies m on m.movie_id = wh.movie_id where wh.user_id = 
(select target_user_id from params)), rating_neighbors_raw as (select r2.user_id as neighbor_id, round(avg(1 - abs(r1.rating - r2.rating) / 4), 4) as sim_score from ratings r1 join ratings r2 on r2.movie_id = r1.movie_id
 where r1.user_id = (select target_user_id from params) and r2.user_id <> (select target_user_id from params) group by r2.user_id having count(*) >= 2), rating_neighbors as (select neighbor_id, sim_score from rating_neighbors_raw where sim_score > 0.40 order by sim_score desc limit 20), 
 rating_candidates as (select 'rating_pattern' as dimension, m.movie_id, m.title, m.genre, round(avg(r.rating), 3) as dim_score, count(distinct rn.neighbor_id) as neighbor_votes from rating_neighbors rn join ratings r on r.user_id = rn.neighbor_id join movies m on m.movie_id = r.movie_id left join target_seen ts on ts.movie_id = m.movie_id where ts.movie_id is null group by m.movie_id, m.title, m.genre), genre_neighbors_raw as (select wh.user_id as neighbor_id, count(*) as sim_score from watch_history wh join movies m on m.movie_id = wh.movie_id join target_genres tg on tg.genre = m.genre where wh.user_id <> 
 (select target_user_id from params) group by wh.user_id), genre_neighbors as (select neighbor_id, sim_score from genre_neighbors_raw where sim_score >= 2 order by sim_score desc limit 20), genre_candidates as (select 'genre_affinity' as dimension, m.movie_id, m.title, m.genre,
 round(avg(r.rating), 3) as dim_score, count(distinct gn.neighbor_id) as neighbor_votes from genre_neighbors gn join ratings r on r.user_id = gn.neighbor_id join movies m on m.movie_id = r.movie_id left join target_seen ts on ts.movie_id = m.movie_id where ts.movie_id is null group by m.movie_id, m.title, m.genre), 
 all_dimension_candidates as (select * from rating_candidates union all select * from genre_candidates) select movie_id, title, genre, round(avg(dim_score), 3) as avg_dim_score, count(distinct dimension) as dimension_agreement, group_concat(dimension order by dimension separator ' | ') 
 as contributing_dimensions, sum(neighbor_votes) as total_neighbor_votes, round(avg(dim_score) * count(distinct dimension), 3) as final_score from all_dimension_candidates group by movie_id, title, genre order by dimension_agreement desc, final_score desc, total_neighbor_votes desc, title;

-- neighbooring users
with params as (select 1 as target_user_id), target_genres as (select distinct m.genre from watch_history wh join movies m on 
m.movie_id = wh.movie_id where wh.user_id = (select target_user_id from params)), rating_neighbors as (select 'rating_pattern' as dimension, r2.user_id as 
neighbor_id, round(avg(1 - abs(r1.rating - r2.rating) / 4), 4) as sim_score from ratings r1 join ratings r2 on r2.movie_id = r1.movie_id where r1.user_id = (select target_user_id from params) and r2.user_id <> (select target_user_id from params) group by r2.user_id having count(*) >= 2), genre_neighbors as 
(select 'genre_affinity' as dimension, wh.user_id as neighbor_id, count(*) as sim_score from watch_history wh join movies m on m.movie_id = wh.movie_id join target_genres tg on tg.genre = m.genre where wh.user_id <> 
(select target_user_id from params) group by wh.user_id), all_neighbors as (select * from rating_neighbors union all select * from genre_neighbors) 
select an.dimension, u.user_id, u.name, an.sim_score from all_neighbors an join users u on u.user_id = an.neighbor_id where an.sim_score > 0 order by an.dimension, an.sim_score desc, u.user_id;
--treding 
select m.movie_id, m.title, m.genre, count(*) as watches_last_7d, round(avg(r.rating), 2) as avg_rating from watch_history wh join movies m on m.movie_id = wh.movie_id 
left join ratings r on r.movie_id = m.movie_id where wh.watch_date >= current_date - interval 7 
day group by m.movie_id, m.title, m.genre 
having count(*) >= 2 order by watches_last_7d desc, avg_rating desc, m.title;
