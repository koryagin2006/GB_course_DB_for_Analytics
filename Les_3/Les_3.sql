USE db_for_analyt;

SELECT DATABASE();

SHOW TABLES;

DESCRIBE db_for_analyt.orders_all;

CREATE TABLE db_for_analyt.orders_all_s
SELECT *
  FROM db_for_analyt.orders_all oa
  WHERE year(o_date) = 2017;