CREATE TABLE time_user_b
SELECT
  user_id,
  COUNT(id_o) n,
  DATE('2017-01-01') m
FROM orders_20190822 o
WHERE o_date(o_date) < DATE('2017-01-01')
GROUP BY user_id;

INSERT INTO time_user_b
  SELECT
    user_id,
    COUNT(id_o) n,
    DATE('2017-02-01')
  FROM orders_20190822 o
  WHERE DATE(o_date) < DATE('2017-02-01')
  GROUP BY user_id;

-- и ид до 12 месяца

CREATE TABLE time_user_ym_s
SELECT
  user_id,
  DATE_FORMAT(o_date, '%y%m') ym,
  SUM(price) s
FROM orders_20190822 o
GROUP BY user_id,
         DATE_FORMAT(o_date, '%y%m');

CREATE TABLE ttt
SELECT
  t.n,
  COUNT(DISTINCT t.user_id),
  COUNT(s.user_id),
  SUM(s.s),
  COUNT(s.user_id) / COUNT(DISTINCT t.user_id) AS p,
  SUM(s.s) / COUNT(s.user_id) AS s_m,
  s.ym
FROM time_user_b t
  LEFT JOIN time_user_ym_s s
    ON t.user_id = s.user_id
WHERE t.m = DATE('2017-01-01')
AND s.ym = '1701'
GROUP BY t.n;

INSERT INTO ttt
  SELECT
    t.n,
    COUNT(DISTINCT t.user_id),
    COUNT(s.user_id),
    SUM(s.s),
    COUNT(s.user_id) / COUNT(DISTINCT t.user_id) AS p,
    SUM(s.s) / COUNT(s.user_id) AS s_m,
    '1702'
  FROM time_user_b t
    LEFT JOIN time_user_ym_s s
      ON t.user_id = s.user_id
  WHERE t.m = DATE('2017-02-01')
  AND s.ym = '1702'
  -- and t.n = 1
  GROUP BY t.n;

INSERT INTO ttt
  SELECT
    t.n,
    COUNT(DISTINCT t.user_id),
    COUNT(s.user_id),
    SUM(s.s),
    COUNT(s.user_id) / COUNT(DISTINCT t.user_id) AS p,
    SUM(s.s) / COUNT(s.user_id) AS s_m,
    '1703'
  FROM time_user_b t
    LEFT JOIN time_user_ym_s s
      ON t.user_id = s.user_id
  WHERE t.m = DATE('2017-03-01')
  AND s.ym = '1703'
  GROUP BY t.n;

-- и далее до 12