-- drop existing tables first
DROP TABLE IF EXISTS watch_history;
drop table if exists ratings;
DROP table if exists movies;
drop table if exists users;

CREATE TABLE users (
    user_id int primary key,
    name varchar(100) NOT NULL,
    age int check(age >= 0)
);

CREATE TABLE movies (
    movie_id INT primary key,
    title varchar(200) not null,
    genre VARCHAR(80) not null,
    runtime_minutes int not null check (runtime_minutes > 0)
);

-- users rating movies
create table ratings (
    user_id int not null,
    movie_id int not null,
    rating decimal(2,1) not null check(rating>=0 and rating<=5),
    PRIMARY KEY (user_id, movie_id),
    CONSTRAINT fk_ratings_user foreign key(user_id) references users(user_id),
    CONSTRAINT fk_ratings_movie FOREIGN KEY (movie_id) references movies (movie_id)
);

create table watch_history (
    user_id INT not null,
    movie_id INT not null,
    watch_date date not null,
    watch_duration_minutes int not null check (watch_duration_minutes>=0),
    PRIMARY KEY (user_id, movie_id, watch_date),
    constraint fk_watch_user foreign key (user_id) references users(user_id),
    constraint fk_watch_movie foreign key(movie_id) references movies(movie_id)
);

-- indexes for faster queries
create index idx_movies_genre on movies(genre);
create index idx_ratings_movie on ratings(movie_id);
create index idx_watch_movie_date on watch_history(movie_id, watch_date);
CREATE INDEX idx_watch_user_date on watch_history(user_id, watch_date);
