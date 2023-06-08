DROP DATABASE IF EXISTS lesson6;
CREATE DATABASE IF NOT EXISTS lesson6;
USE lesson6;

/*
1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds ' 
*/

DELIMITER //

DROP FUNCTION IF EXISTS Days//
CREATE FUNCTION Days (value INT)
RETURNS TEXT DETERMINISTIC
BEGIN 
  DECLARE DD, HH, MINS, SECS INT DEFAULT 0;
  
  SET SECS = value % 60;
  SET DD = value DIV (3600 * 24);
  SET value = value - DD * 24 * 3600;
  SET HH = value DIV 3600;
  SET value = value - HH * 3600;
  SET MINS = value DIV 60;
    
  RETURN CONCAT(DD, ' days ', HH, ' hours ', MINS, ' minutes ', SECS, ' seconds');
END; //

DELIMITER ;

SELECT Days(123456);

/*
Выведите только четные числа от 1 до 10. Пример: 2,4,6,8,10
*/
DELIMITER //

DROP PROCEDURE IF EXISTS Even //
CREATE PROCEDURE Even (num INT)
BEGIN
  DECLARE i INT DEFAULT 3;
  DECLARE evens TINYTEXT DEFAULT '2';
  IF (num >= 2) THEN
	WHILE i <= num DO
  	  IF (i % 2 = 0) THEN
        SET evens = CONCAT(evens, ', ', CAST(i AS CHAR));
        END IF;
	  SET i = i + 1;
	END WHILE;
    SELECT evens;
  ELSE
	SELECT NULL;
  END IF;
  
END; //

DELIMITER ;

CALL Even(10);
