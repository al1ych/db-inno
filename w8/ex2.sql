create table Ledger(
	ledger_id integer primary key,
	from_id integer references account(account_id),
	to_id integer references account(account_id),
	fee integer,
	amount integer,
	transactionDateTime timestamp
);

begin;
update account set credit = credit - 500 where account.account_id = 1;
update account set credit = credit + 500 where account.account_id = 3;
insert into Ledger values(1, 1, 3, 0, 500, now());
update account set credit = credit - 700 where account.account_id = 2;
update account set credit = credit + 700 where account.account_id = 1;
update account set credit = credit - 30 where account.account_id = 2;
update account set credit = credit + 30 where account.account_id = 4;
insert into Ledger values(2, 2, 1, 30, 700, now());
update account set credit = credit - 100 where account.account_id = 2;
update account set credit = credit + 100 where account.account_id = 3;
update account set credit = credit - 30 where account.account_id = 2;
update account set credit = credit + 30 where account.account_id = 4;
insert into Ledger values(3, 2, 3, 30, 100, now());
select a.credit from account a;
rollback;
