SELECT year(o_date),MONTH(o_date),count(DISTINCT id_o),SUM(price) s
FROM ds.orders_st
GROUP BY year(o_date),MONTH(o_date);


SELECT * -- year(o_date),MONTH(o_date),count(DISTINCT id_o),SUM(price) s
FROM ds.orders_st
  WHERE price > 100 AND price < 100000;

SELECT MIN(o_date),MAX(o_date) -- year(o_date),MONTH(o_date),count(DISTINCT id_o),SUM(price) s
FROM ds.orders_st;

-- G по N
SELECT user_id
  -- ,TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')),SUM(price) s,
  -- COUNT(id_o)/TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')) -- MIN(o_date),MAX(o_date)
FROM ds.orders_20190822
GROUP BY user_id
HAVING COUNT(id_o)/TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')) < 11
;


-- G по S
SELECT user_id
  -- ,TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')),SUM(price) s,
  -- COUNT(id_o)/TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')) -- MIN(o_date),MAX(o_date)
FROM ds.orders_20190822
GROUP BY user_id
HAVING sum(price)/TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')) < 100000
;
  

SELECT user_id,COUNT(DISTINCT date(o_date))
  FROM ds.orders_20190822
  GROUP BY user_id;


CREATE TABLE orders_20190822_cor
SELECT * -- year(o_date),MONTH(o_date),count(DISTINCT id_o),SUM(price) s
FROM ds.orders_20190822
  WHERE price > 100 AND price < 100000
AND user_id IN 

(SELECT user_id
  -- ,TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')),SUM(price) s,
  -- COUNT(id_o)/TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')) -- MIN(o_date),MAX(o_date)
FROM ds.orders_20190822
GROUP BY user_id
HAVING COUNT(id_o)/TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')) < 11)
AND user_id IN 

(SELECT user_id
  -- ,TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')),SUM(price) s,
  -- COUNT(id_o)/TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')) -- MIN(o_date),MAX(o_date)
FROM ds.orders_20190822
GROUP BY user_id
HAVING sum(price)/TIMESTAMPDIFF(MONTH,MIN(o_date),date('2017-12-31')) < 100000);

DROP TABLE orders_20190822_s_cog;
CREATE TABLE ds.orders_20190822_s_cog
SELECT user_id,DATE_FORMAT(MIN(o_date),'%y%m') AS cog
  FROM ds.orders_20190822_s
  GROUP BY user_id;

SELECT user_id,o_date, DATE_FORMAT((o_date),'%y%m')
  FROM ds.orders_20190822_s
  LIMIT 100


CREATE TABLE ds.orders_20190822_s
SELECT * -- user_id,year(MIN(o_date)) y,month(MIN(o_date)) m,CONCAT(year(MIN(o_date)),month(MIN(o_date))) AS cog
  FROM ds.orders_20190822
  WHERE year(o_date) = 2017;

SELECT *
  FROM ds.orders_20190822_s_cog;

SELECT c.cog,DATE_FORMAT((o_date),'%y%m'),SUM(price) s 
  FROM ds.orders_20190822_s o
  JOIN ds.orders_20190822_s_cog c 
  ON c.user_id = o.user_id
 -- WHERE c.cog = '1701'
  GROUP BY c.cog,DATE_FORMAT((o_date),'%y%m');
  
