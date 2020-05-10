/*
Исходник данных: продажи за 2 года.

На 2016.12.31 получаем инфу по кол-ву заказов на каждого юзера. 
Подсчитываем сколько пользователей попало в группу с 1 заказом, 2, 3 и т.д.
За январь 2017 смотрим, какое кол-во юзеров из п.1 купило в каждой группе и на какую сумму за месяц.
  (скрипты вам должны помочь)
Подсчитываем вероятность перехода в покупающего по каждой группе и ср траты за январь в группе (как на занятии).
В идеале сделать тоже самое на февраль, март, и до конца 17 года (чтобы оценить сезонность и рост трат за месяц).
*/

-- по мес
DROP TABLE one_month_table;
CREATE TABLE one_month_table (
SELECT 
	user_id,
	COUNT(id_o) AS n,
	MONTH(o_date) AS date_m,
	YEAR(o_date) AS date_y
FROM orders_20190822 o
WHERE price BETWEEN 0 AND 150000
GROUP BY user_id, date_m, date_y);

SELECT * FROM one_month_table;

SELECT DISTINCT(n) FROM one_month_table ORDER BY n DESC;

SELECT 
	COUNT(omt.user_id) AS count_users,
	CASE 
		WHEN n < 5 THEN 1
		WHEN n BETWEEN 5 AND 10 THEN 2
		WHEN n BETWEEN 11 AND 20 THEN 3
		WHEN n > 20 THEN 4 END AS buyer_group,
	date_m,
	date_y,
	sum(o.price) AS summ
FROM one_month_table omt
LEFT JOIN orders_20190822 AS o
ON omt.user_id = o.user_id
WHERE 
	o.price BETWEEN 0 AND 150000 AND 
	o.o_date < DATE('2017-01-01') AND
	DATE(concat(omt.date_y,'-',omt.date_m,'-','01')) < DATE('2017-01-01')
GROUP BY buyer_group, omt.date_m, omt.date_y;
