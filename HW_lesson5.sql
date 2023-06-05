CREATE DATABASE lesson5;
USE lesson5;

CREATE TABLE IF NOT EXISTS cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, 'Audi', 52642),
    (2, 'Mercedes', 57127 ),
    (3, 'Skoda', 9000 ),
    (4, 'Volvo', 29000),
	(5, 'Bentley', 350000),
    (6, 'Citroen ', 21000 ), 
    (7, 'Hummer', 41400), 
    (8, 'Volkswagen ', 21600);

SELECT * FROM cars;

/*
1. Создайте представление, в которое попадут
автомобили стоимостью до 25 000 долларов */

CREATE VIEW cars_cheap
    AS SELECT *
    FROM cars
    WHERE cost < 25000;

SELECT * FROM cars_cheap;

/*
2. Изменить в существующем представлении порог
для стоимости: пусть цена будет до 30 000 долларов
(используя оператор ALTER VIEW)*/

ALTER VIEW cars_cheap
    AS SELECT *
    FROM cars
    WHERE cost < 30000;

SELECT * FROM cars_cheap;
/*
3. Создайте представление, в котором будут только
автомобили марки “Шкода” и “Ауди */

-- Вариант с новым представлением

CREATE VIEW cars_skoda_audi
    AS SELECT *
    FROM cars
    WHERE name IN ('Skoda', 'Audi');

SELECT * FROM cars_skoda_audi;

-- Вариант с изменением предыдущего представления

ALTER VIEW cars_cheap
    AS SELECT *
    FROM cars
    WHERE name IN ('Skoda', 'Audi');

SELECT * FROM cars_cheap;

/*
 Добавьте новый столбец под названием «время до следующей станции».
 */

CREATE TABLE IF NOT EXISTS train_schedule
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_train INT NOT NULL,
    station VARCHAR(20),
    arriving_time TIME
);

INSERT train_schedule (id_train, station, arriving_time)
VALUES
(110, 'San Francisco', '10:00:00'),
(110, 'Redwood City', '10:54:00'),
(110, 'Palo Alto', '11:02:00'),
(110, 'San Jose', '11:35:00'),
(120, 'San Francisco', '11:00:00'),
(120, 'Palo Alto', '12:49:00'),
(120, 'San Jose', '13:30:00');

SELECT * FROM train_schedule;

SELECT 
	*,
    TIMEDIFF(LEAD(arriving_time, 1) OVER (PARTITION BY id_train ORDER BY arriving_time), arriving_time) AS 'travel time'
FROM train_schedule;
