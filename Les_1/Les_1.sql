/*
«алить в свою Ѕƒ данные по продажам (часть таблицы Orders в csv, исходник здесь
https://drive.google.com/drive/folders/1C3HqIJcABblKM2tz8vPGiXTFT7MisrML?usp=sharin
g )
2. ѕроанализировать, какой период данных выгружен
3. ѕосчитать кол-во строк, кол-во заказов и кол-во уникальных пользователей, кот
совершали заказы.
4. ѕо годам посчитать средний чек, среднее кол-во заказов на пользовател€, сделать
вывод , как измен€лись это показатели √од от года.
5. Ќайти кол-во пользователей, кот покупали в одном году и перестали покупать в
следующем.
6. Ќайти ID самого активного по кол-ву покупок пользовател€. */

CREATE DATABASE IF NOT EXISTS db_for_analyt

USE db_for_analyt

CREATE TABLE `orders` (
  `id_o` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `o_date` date DEFAULT NULL)


SELECT * FROM orders_20190822
