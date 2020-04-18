USE db_for_analyt;

-- Просмотр периода дат таблицы
SELECT MIN(o_date),MAX(o_date)
FROM orders_20190822;

-- Отбор заказов только с суммой выше 100 и меньше 100 т.р.
SELECT * FROM orders_20190822
WHERE price > 100 AND price < 100000;


-- Отбор покупателей, если поличество из заказов в месяц меньше 11
SELECT user_id
FROM orders_20190822
GROUP BY user_id
HAVING COUNT(id_o)/TIMESTAM
PDIFF(MONTH,MIN(o_date),date('2017-12-31')) < 11;


-- Отбор покупателей, если сумма заказов в месяц меньше 100 т.р.
SELECT user_id
FROM orders_20190822
GROUP BY user_id
HAVING sum(price)/TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')) < 100000;

-- Показать покупателей и на каждого количество дней, когда он делал заказ
SELECT user_id, COUNT(DISTINCT DATE(o_date))
FROM orders_20190822
GROUP BY user_id;




-- все перечисленное выше...
/*
SELECT *
FROM orders_20190822
WHERE
	price > 100
	AND price < 100000
	AND user_id IN (
		SELECT user_id
		FROM orders_20190822
		GROUP BY user_id
		HAVING
			COUNT(id_o)/ TIMESTAMPDIFF( MONTH,MIN(o_date),DATE('2017-12-31') ) < 11)
	AND user_id IN (
		SELECT user_id
		FROM orders_20190822
		GROUP BY user_id
		HAVING
			SUM(price)/ TIMESTAMPDIFF(MONTH,MIN(o_date),DATE('2017-12-31')) < 100000);
*/
