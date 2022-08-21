ALTER SESSION SET current_schema = sa_products;

-- Inseting test data about stores into sa_store_data table
INSERT INTO sa_store_data VALUES ('Minks, Kalinouskaga, 33', 'Belarus', 'Minsk', 'Minsk', '+375291122892');
INSERT INTO sa_store_data VALUES ('Minks, Byady, 3', 'Belarus', 'Minsk', 'Minsk', '+375291122892');
INSERT INTO sa_store_data VALUES ('Minks, Zaporozhskaya, 73', 'Belarus', 'Minsk', 'Minsk', '+375291522852');
INSERT INTO sa_store_data VALUES ('Grodno, Savetskaya, 2', 'Belarus', 'Grodno', 'Grodno', '+375291122552');
INSERT INTO sa_store_data VALUES ('Grodno, Kirova, 13', 'Belarus', 'Grodno', 'Grodno', '+375294322892');
INSERT INTO sa_store_data VALUES ('Grodno, Kalinouskaga, 7', 'Belarus', 'Grodno', 'Grodno', '+375290122892');
INSERT INTO sa_store_data VALUES ('Slonim, Skaryny, 18', 'Belarus', 'Grodno', 'Slonim', '+375290292892');
INSERT INTO sa_store_data VALUES ('Novogrudok, Kalinouskaga, 1', 'Belarus', 'Grodno', 'Novogrudok', '+375788822892');
INSERT INTO sa_store_data VALUES ('Brest, Kalinouskaga, 47', 'Belarus', 'Brest', 'Brest', '+375290120092');
INSERT INTO sa_store_data VALUES ('Mogilev, Kalinouskaga, 17', 'Belarus', 'Mogilev', 'Mogilev', '+375290121234');
INSERT INTO sa_store_data VALUES ('Vitebsk, Kalinouskaga, 9', 'Belarus', 'Vitebsk', 'Vitebsk', '+375291111892');
INSERT INTO sa_store_data VALUES ('Gomel, Kalinouskaga, 6', 'Belarus', 'Gomel', 'Gomel', '+375291110892');
INSERT INTO sa_store_data VALUES ('Kyiv, Kalinouskaga, 11', 'Ukraine', 'Kyiv', 'Kyiv', '+380291144894');
INSERT INTO sa_store_data VALUES ('Moscow, Kalinouskaga, 12', 'Russian Federation', 'Moscow', 'Moscow', '+71232131232');
INSERT INTO sa_store_data VALUES ('Saint Petersburg, Kalinouskaga, 90', 'Russian Federation', 'Leningrad', 'Saint Petersburg', '+71277131232');
INSERT INTO sa_store_data VALUES ('Astana, Kalinouskaga, 90', 'Kazakhstan', 'Astana', 'Astana', '+99677131211');

COMMIT;
