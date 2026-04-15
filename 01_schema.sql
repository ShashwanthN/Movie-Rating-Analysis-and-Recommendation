
drop table if exists watch_history;
drop table if exists ratings;
drop table if exists movies;
drop table if exists users;


create table users (
  user_id int primary key,
  name    varchar(100) not null,
  age     int check (age >= 0)
);


create table movies (
  movie_id        int primary key,
  title           varchar(200) not null,
  genre           varchar(80)  not null,
  runtime_minutes int          not null check (runtime_minutes > 0)
);

create table ratings (
  user_id  int not null,
  movie_id int not null,
  rating   decimal(2,1) not null check (rating >= 0 and rating <= 5),
  primary key (user_id, movie_id),
  constraint fk_ratings_user  foreign key (user_id)  references users  (user_id),
  constraint fk_ratings_movie foreign key (movie_id) references movies (movie_id)
);


create table watch_history (
  user_id   int  not null,
  movie_id  int  not null,
  watch_date   date not null,
  watch_duration_minutes int  not null check (watch_duration_minutes >= 0),
  primary key (user_id, movie_id, watch_date),
  constraint fk_watch_user  foreign key (user_id)  references users  (user_id),
  constraint fk_watch_movie foreign key (movie_id) references movies (movie_id)
);


create index idx_movies_genre  on movies (genre);
create index idx_ratings_movie  on ratings (movie_id);
create index idx_watch_movie_date  on watch_history (movie_id, watch_date);
create index idx_watch_user_date   on watch_history (user_id,  watch_date);
