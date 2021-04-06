# -- read committed --

# t 1
accounts=*# begin transaction isolation level read commited;
BEGIN

accounts=*# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 jones    | Alice Jones      |      82 |        1
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 (5 rows)

# t 2
accounts=*# begin transaction isolation level read commited;
BEGIN

accounts=*# update account set username='ajones' where fullname='Alice Jones';
UPDATE 1

# t 1
accounts=*# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 jones    | Alice Jones      |      82 |        1
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
(5 rows)

# t 2
accounts=*# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 ajones   | Alice Jones      |      82 |        1
(5 rows)

# both show different results, since transaction does not apply changes to the database until transaction is committed

# t 2
accounts=*# COMMIT;
COMMIT
accounts=# select * FROM account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 ajones   | Alice Jones      |      82 |        1
(5 rows)

# t 1
accounts=*# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 ajones   | Alice Jones      |      82 |        1
(5 rows)

# t 2
accounts=# begin transaction isolation level read committed;
BEGIN

# t 1
accounts=*# UPDATE account SET balance=92 WHERE fullname='Alice Jones';
UPDATE 1

# t 2
accounts=*# UPDATE account SET balance=102 WHERE fullname='Alice Jones';
# here the terminal is locked, because of terminal 1. this prevents race conditions

# t 1
accounts=*# COMMIT;
COMMIT

# t 2
# the terminal is unlocked after commit from terminal#1
accounts=*# ROLLBACK;
ROLLBACK

accounts=# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 ajones   | Alice Jones      |      92 |        1
(5 rows)

# -- repeatable read --
# t 1
accounts=*# begin transaction isolation level repeatable read;
BEGIN
accounts=*# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 jones    | Alice Jones      |      82 |        1
(5 rows)

# t 2
accounts=*# begin transaction isolation level repeatable read;
BEGIN
accounts=*# update account set username='ajones' where fullname='Alice Jones';
UPDATE 1

# t 1
accounts=*# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 jones    | Alice Jones      |      82 |        1
(5 rows)

# t 2
accounts=*# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 ajones   | Alice Jones      |      82 |        1
(5 rows)


# both show different results, since transaction does not apply changes to the database until transaction is committed

# t 2
accounts=*# COMMIT;
COMMIT
accounts=# select * FROM account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 ajones   | Alice Jones      |      82 |        1
(5 rows)

# t 1
accounts=*# select * FROM account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 jones    | Alice Jones      |      82 |        1
(5 rows)

# t 2
accounts=# begin transaction isolation level repeatable read;
BEGIN

# t 1
accounts=*# update account set balance=92 where fullname='Alice Jones';
UPDATE 1

# t 2
accounts=*# update account set balance=102 where fullname='Alice Jones';
# here the terminal is locked, because of terminal#1. this prevents race conditions

# t 1
accounts=*# COMMIT;
COMMIT

# t 2
# the terminal is unlocked after commit from terminal#1
# output:
accounts=*# update account set balance=102 where fullname='Alice Jones';
ERROR:  could not serialize access due to concurrent update

accounts=*# ROLLBACK;
ROLLBACK

accounts=# select * from account;
 username |     fullname     | balance | group_id
----------+------------------+---------+----------
 bitdiddl | Ben Bitdiddle    |      65 |        1
 mike     | Michael Dole     |      73 |        2
 alyssa   | Alyssa P. Hacker |      79 |        3
 bbrown   | Bob Brown        |     100 |        3
 ajones   | Alice Jones      |      92 |        1
(5 rows)