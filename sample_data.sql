-- artificially llm generated data
insert into users (user_id, name, age) values
  (1, 'Asha',  24),
  (2, 'Rahul', 31),
  (3, 'Meera', 27),
  (4, 'Arjun', 22),
  (5, 'Ishan', 35),
  (6, 'Nina',  29);


insert into movies (movie_id, title, genre, runtime_minutes) values
  (101, 'The Silent Orbit',  'Sci-Fi',  120),
  (102, 'Broken Compass',    'Drama',   105),
  (103, 'Laughing Streets',  'Comedy',   90),
  (104, 'Crimson Tidefall',  'Action',  115),
  (105, 'Letters to Winter', 'Romance',  95),
  (106, 'Echoes of Marble',  'Mystery', 100),
  (107, 'Zero Hour Signal',  'Sci-Fi',  122),
  (108, 'Field of Feathers', 'Drama',   108),
  (109, 'Skyline Chasers',   'Action',  112),
  (110, 'Paper Lanterns',    'Romance',  98);

insert into ratings (user_id, movie_id, rating) values
  (1, 101, 4.5), (1, 102, 3.5), (1, 107, 5.0), (1, 109, 4.0),
  (2, 101, 4.0), (2, 104, 4.5), (2, 109, 4.5), (2, 106, 3.0),
  (3, 102, 4.0), (3, 105, 4.5), (3, 110, 4.0), (3, 108, 3.5),
  (4, 103, 4.0), (4, 104, 3.5), (4, 109, 4.0), (4, 107, 4.5),
  (5, 101, 3.5), (5, 106, 4.5), (5, 107, 4.0), (5, 108, 4.0),
  (6, 102, 4.0), (6, 105, 3.5), (6, 110, 4.5), (6, 103, 3.5);


insert into watch_history (user_id, movie_id, watch_date, watch_duration_minutes) values

(1, 101, current_date - interval 12 day, 118),
(1, 107, current_date - interval  8 day, 120),
(1, 109, current_date - interval  4 day, 110),
(1, 102, current_date - interval  2 day,  72),
(2, 101, current_date - interval 14 day, 116),
(2, 104, current_date - interval 10 day, 115),
(2, 109, current_date - interval  5 day, 112),
(2, 106, current_date - interval  1 day,  58),
(3, 102, current_date - interval 13 day, 104),
(3, 105, current_date - interval  9 day,  94),
(3, 110, current_date - interval  6 day,  97),
(3, 108, current_date - interval  2 day, 106),
(4, 103, current_date - interval 11 day,  88),
(4, 104, current_date - interval  7 day,  92),
(4, 109, current_date - interval  3 day, 112),
(4, 107, current_date - interval  1 day, 119),
(5, 101, current_date - interval 15 day, 120),
(5, 106, current_date - interval  8 day, 100),
(5, 107, current_date - interval  4 day, 120),
(5, 108, current_date - interval  1 day,  52),
(6, 102, current_date - interval 10 day,  78),
(6, 105, current_date - interval  5 day,  94),
(6, 110, current_date - interval  2 day,  97),
(6, 103, current_date - interval  1 day,  88);
