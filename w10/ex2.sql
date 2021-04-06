# -- read committed --
# terminal 1
accounts=# begin transaction isolation level read committed;
BEGIN

# terminal 2
accounts=# begin transaction isolation level read committed;
BEGIN

# terminal 1
accounts=*# select * from account where group_id = 2;
 username |   fullname   | balance | group_id
----------+--------------+---------+----------
 mike     | Michael Dole |      73 |        2
(1 row)

# terminal 2
accounts=*# update account set group_id=2 where username='bbrown';
UPDATE 1

# terminal 1
accounts=*# select * from account where group_id=2;
 username |   fullname   | balance | group_id
----------+--------------+---------+----------
 mike     | Michael Dole |      73 |        2
(1 row)

accounts=*# update account set balance=balance+15 where username = (select username from account where group_id=2);
UPDATE 1

accounts=*# select * from account where group_id=2;
 username |   fullname   | balance | group_id
----------+--------------+---------+----------
 mike     | Michael Dole |      88 |        2
(1 row)

accounts=*# COMMIT;
COMMIT

# terminal 2
accounts=*# COMMIT;
COMMIT

accounts=# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 alyssa   | Alyssa P. Hacker |      79 |        3
 ajones   | Alice Jones      |      92 |        1
 bbrown   | Bob Brown        |     100 |        2
 mike     | Michael Dole     |      88 |        2
(5 rows)
# since both transactions made changes at distinct places, there was no conflicts => no locks on updates


# -- repeatable read --
# terminal 1
accounts=# begin transaction isolation level read committed;
BEGIN

# terminal 2
accounts=# begin transaction isolation level read committed;
BEGIN

# terminal 1
accounts=*# select * from account WHERE group_id=2;
 username |   fullname   | balance | group_id
----------+--------------+---------+----------
 mike     | Michael Dole |      88 |        2
(1 row)

# terminal 2
accounts=*# update account set group_id=2 where username='bbrown';
UPDATE 1

# terminal 1
accounts=*# select * from account where group_id=2;
 username |   fullname   | balance | group_id
----------+--------------+---------+----------
 mike     | Michael Dole |      88 |        2
(1 row)

accounts=*# update account set balance = balance+15 where username = (select username from account where group_id=2);
UPDATE 1

accounts=*# select * from account where group_id=2;
 username |   fullname   | balance | group_id
----------+--------------+---------+----------
 mike     | Michael Dole |     103 |        2
(1 row)

accounts=*# COMMIT;
COMMIT

# terminal 2
accounts=*# COMMIT;
COMMIT

accounts=# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 alyssa   | Alyssa P. Hacker |      79 |        3
 ajones   | Alice Jones      |      92 |        1
 bbrown   | Bob Brown        |     100 |        2
 mike     | Michael Dole     |     103 |        2
(5 rows)

# since both transactions made changes at distinct places, there was no conflicts => no locks on updates