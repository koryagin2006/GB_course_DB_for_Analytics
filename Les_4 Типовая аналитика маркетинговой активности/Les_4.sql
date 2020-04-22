﻿CREATE table time_user_b;

SELECT user_id, COUNT(id_o) n, DATE('2017-01-01') m 
From orders_20190822 o 
  Where DATE(o_date) < DATE('2017-01-01')
  GROUP BY user_id;

  insert INTO time_user_b 
    Select user_id,count(id_o) n,date('2017-02-01')
From orders 
  Where o_date(o_date) < date('2017-02-01')
  Group by user_id;

  insert INTO time_user_b 
    Select user_id,count(id_o) n,date('2017-03-01')
From orders 
  Where o_date(o_date) < date('2017-03-01')
  Group by user_id;

  insert INTO time_user_b 
    Select user_id,count(id_o) n,date('2017-04-01')
From orders 
  Where o_date(o_date) < date('2017-04-01')
  Group by user_id;

  insert INTO time_user_b 
    Select user_id,count(id_o) n,date('2017-05-01')
From orders 
  Where o_date(o_date) < date('2017-05-01')
  Group by user_id;

  insert INTO time_user_b 
    Select user_id,count(id_o) n,date('2017-06-01')
From orders 
  Where o_date(o_date) < date('2017-06-01')
  Group by user_id;

create table time_user_ym_s
  Select user_id, date_format(o_date,'%y%m') ym,sum(price) s
  From orders
    Group by user_id, date_format(o_date,'%y%m');

CREATE table ttt
Select t.n,count(distinct t.user_id),count(s.user_id),sum(s.s),
  count(s.user_id)/count(distinct t.user_id) as p,
  sum(s.s)/count(s.user_id) as s_m,'1701'
  From time_user_b t
  LEFT join time_user_ym_s s
  on t.user_id = s.user_id
  Where t.m = date('2017-01-01') and s.ym = '1701'
  -- and t.n = 1
  Group by t.n;
  -- HAVING t.n = 1
insert into ttt
  Select t.n,count(distinct t.user_id),count(s.user_id),sum(s.s),
  count(s.user_id)/count(distinct t.user_id) as p,
  sum(s.s)/count(s.user_id) as s_m,'1702'
  From time_user_b t
  LEFT join time_user_ym_s s
  on t.user_id = s.user_id
  Where t.m = date('2017-02-01') and s.ym = '1702'
  -- and t.n = 1
  Group by t.n;

insert into ttt
  Select t.n,count(distinct t.user_id),count(s.user_id),sum(s.s),
  count(s.user_id)/count(distinct t.user_id) as p,
  sum(s.s)/count(s.user_id) as s_m,'1703'
  From time_user_b t
  LEFT join time_user_ym_s s
  on t.user_id = s.user_id
  Where t.m = date('2017-03-01') and s.ym = '1703'
  -- and t.n = 1
  Group by t.n;

Select t.n,count(distinct t.user_id),count(s.user_id),sum(s.s),
  count(s.user_id)/count(distinct t.user_id) as p,
  sum(s.s)/count(s.user_id) as s_m,'1704'
  From time_user_b t
  LEFT join time_user_ym_s s
  on t.user_id = s.user_id
  Where t.m = date('2017-04-01') and s.ym = '1704'
  -- and t.n = 1
  Group by t.n;
  -- HAVING t.n = 1
insert into ttt
  Select t.n,count(distinct t.user_id),count(s.user_id),sum(s.s),
  count(s.user_id)/count(distinct t.user_id) as p,
  sum(s.s)/count(s.user_id) as s_m,'1705'
  From time_user_b t
  LEFT join time_user_ym_s s
  on t.user_id = s.user_id
  Where t.m = date('2017-05-01') and s.ym = '1705'
  -- and t.n = 1
  Group by t.n;

insert into ttt
  Select t.n,count(distinct t.user_id),count(s.user_id),sum(s.s),
  count(s.user_id)/count(distinct t.user_id) as p,
  sum(s.s)/count(s.user_id) as s_m,'1706'
  From time_user_b t
  LEFT join time_user_ym_s s
  on t.user_id = s.user_id
  Where t.m = date('2017-06-01') and s.ym = '1706'
  -- and t.n = 1
  Group by t.n;