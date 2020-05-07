/*
ДЗ делаем по бд orders
В качестве ДЗ сделаем карту поведения пользователей. 
Мы обсуждали, что всех пользователей можно разделить, к примеру, на 
	New (совершили только 1 покупку), 
	Regular (совершили 2 или более на сумму не более стольки-то), 
	Vip (совершили дорогие покупки и достаточно часто), 
	Lost (раньше покупали хотя бы раз и с даты последней покупки прошло больше 3 месяцев). 
Вся база должна войти в эти гурппы (т.е. каждый пользователь должен попадать только в одну из этих групп).

Задача:
1. Уточнить критерии групп New,Regular,Vip,Lost
2. По состоянию на 1.01.2017 понимаем, кто попадает в какую группу, подсчитываем кол-во пользователей в каждой.
3. По состоянию на 1.02.2017 понимаем, кто вышел из каждой из групп, а кто вошел.
4. Аналогично смотрим состояние на 1.03.2017, понимаем кто вышел из каждой из групп, а кто вошел.
5. В итоге делаем вывод, какая группа уменьшается, какая увеличивается и продумываем, в чем может быть причина.

Присылайте отчет в pdf
*/

USE db_analyt_loc;

-- New, их число
SELECT COUNT(*)
FROM (
SELECT COUNT(user_id)
	FROM orders_20190822
GROUP BY user_id
HAVING COUNT(id_o) = 1) AS t;


-- Lost, их число
SELECT COUNT(t.user_id)
FROM (
SELECT 
	o.user_id,
	TIMESTAMPDIFF(MONTH,MAX(o_date),date('2017-12-31')) AS period_from_last_ord
FROM orders_20190822 AS o
GROUP BY user_id
HAVING COUNT(o.id_o >= 1)) AS t
WHERE period_from_last_ord >= 3;




SELECT user_id, price,
  CASE WHEN price < 1000 THEN "1"
       WHEN price >= 1000 AND price < 5000 THEN "2"
  ELSE "3" end  AS m
  FROM orders_20190822;



SELECT 
  user_id,
  TIMESTAMPDIFF(DAY,MAX(o_date),date('2017-12-31')) AS period_from_last_ord,
  CEILING(COUNT(o.id_o)/TIMESTAMPDIFF(DAY,MIN(o.o_date),MAX(o.o_date))) AS freq,
  ROUND(AVG(o.price),2) as avg_price
FROM orders_20190822 o
GROUP BY o.user_id;
