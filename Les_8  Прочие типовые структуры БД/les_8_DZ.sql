/*
ДЗ делаем по бд orders
В качестве ДЗ сделаем карту поведения пользователей. 
Мы обсуждали, что всех пользователей можно разделить, к примеру, на 
	! New (совершили только 1 покупку), 
	Regular (совершили 2 или более на сумму не более стольки-то), 
	Vip (совершили дорогие покупки и достаточно часто), 
	! Lost (раньше покупали хотя бы раз и с даты последней покупки прошло больше 3 месяцев). 
Вся база должна войти в эти гурппы (т.е. каждый пользователь должен попадать только в одну из этих групп).

Задача:
1. Уточнить критерии групп New,Regular,Vip,Lost
2. По состоянию на 1.01.2017 понимаем, кто попадает в какую группу, подсчитываем кол-во пользователей в каждой.
3. По состоянию на 1.02.2017 понимаем, кто вышел из каждой из групп, а кто вошел.
4. Аналогично смотрим состояние на 1.03.2017, понимаем кто вышел из каждой из групп, а кто вошел.
5. В итоге делаем вывод, какая группа уменьшается, какая увеличивается и продумываем, в чем может быть причина.

Присылайте отчет в pdf
*/

USE db_for_analyt;

-- период базы
SELECT DATE(MIN(o.o_date )), DATE(MAX(o.o_date )) FROM orders_20190822 o;

-- New, их число на '2017-01-01'
SELECT 
  user_id, 
  'New' AS group_,
  DATE('2017-01-01') AS date
FROM 
(SELECT * FROM orders_20190822 WHERE o_date < '2017-01-01') AS o2
GROUP BY user_id
HAVING COUNT(id_o) = 1;


-- Lost, их число на '2017-01-01'
SELECT
  user_id, 
  'Lost' AS group_,
  DATE('2017-01-01') AS date
FROM (
SELECT 
	user_id,
	TIMESTAMPDIFF(MONTH,MAX(o_date),DATE('2017-12-31')) AS period_from_last_ord,
  CEILING(COUNT(o.id_o)/TIMESTAMPDIFF(MONTH,MIN(o.o_date),MAX(o.o_date))) AS freq,
  ROUND(AVG(o.price),2) as avg_price,
  COUNT(o.id_o) AS orders
FROM (SELECT * FROM orders_20190822 WHERE o_date < '2017-01-01') AS o2
GROUP BY user_id
HAVING COUNT(id_o >= 1)) AS t
WHERE period_from_last_ord >= 3;


-- Vip на '2017-01-01' (avg_price>1000 & freq>2)
SELECT
  t2.user_id, 
  'Vip' AS group_,
  DATE('2017-01-01') AS date
FROM (
SELECT 
  user_id,
  CEILING(COUNT(o.id_o)/TIMESTAMPDIFF(MONTH,MIN(o.o_date),MAX(o.o_date))) AS freq,
  ROUND(AVG(o.price),2) as avg_price,
  COUNT(o.id_o) AS orders
FROM orders_20190822 o
GROUP BY o.user_id) AS t2
WHERE t2.freq >2 AND t2.avg_price > 1000 AND t2.orders > 1;


-- Regular на '2017-01-01' (avg_price<=1000 & freq>2)
SELECT 
  *
  /*t2.user_id, 
  'Regular' AS group_,
  DATE('2017-01-01') AS date */
FROM (
SELECT 
  user_id,
  CEILING(COUNT(o.id_o)/TIMESTAMPDIFF(MONTH,MIN(o.o_date),MAX(o.o_date))) AS freq,
  ROUND(AVG(o.price),2) as avg_price,
  COUNT(o.id_o) AS orders
FROM orders_20190822 o
GROUP BY o.user_id) AS t2
WHERE t2.freq >=0 AND t2.avg_price <= 1000 AND t2.orders > 1;


-- вариант 2
SELECT COUNT(DISTINCT o.user_id) FROM orders_20190822 o WHERE o_date < '2017-01-01';

SELECT COUNT(*) FROM orders-all;

SELECT
  *, DATE('2017-01-01') AS date
/*  user_id, 
  'Lost' AS group_, */
FROM (
SELECT 
	user_id,
	TIMESTAMPDIFF(MONTH,MAX(o_date),DATE('2017-12-31')) AS period_from_last_ord,
  CEILING(COUNT(id_o)/TIMESTAMPDIFF(MONTH,MIN(o_date),MAX(o_date))) AS freq,
  ROUND(AVG(price),2) as avg_price,
  COUNT(id_o) AS orders_per_user
FROM (SELECT * FROM orders_20190822 WHERE o_date < '2017-01-01') AS o2
GROUP BY user_id) AS t;
