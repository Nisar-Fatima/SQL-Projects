Create database practise;
use practise;
CREATE TABLE Worker (
    WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);
INSERT INTO Worker 
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
(001, 'Monika', 'Arora', 100000, '2014-02-20 09:00:00', 'HR'),
(002, 'Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 'Admin'),
(003, 'Vishal', 'Singhal', 300000, '2014-02-20 09:00:00', 'HR'),
(004, 'Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 'Admin'),
(005, 'Vivek', 'Bhati', 500000, '2014-06-11 09:00:00', 'Admin'),
(006, 'Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 'Account'),
(007, 'Satish', 'Kumar', 75000, '2014-01-20 09:00:00', 'Account'),
(008, 'Geetika', 'Chauhan', 90000, '2014-04-11 09:00:00', 'Admin');

select * from Worker;

CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT,
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
(001, 5000, '16-02-20'),
(002, 3000, '16-06-11'),
(003, 4000, '16-02-20'),
(001, 4500, '16-02-20'),
(002, 3500, '16-06-11');

CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
(001, 'Manager', '2016-02-20 00:00:00'),
(002, 'Executive', '2016-06-11 00:00:00'),
(008, 'Executive', '2016-06-11 00:00:00'),
(005, 'Manager', '2016-06-11 00:00:00'),
(004, 'Asst. Manager', '2016-06-11 00:00:00'),
(007, 'Executive', '2016-06-11 00:00:00'),
(006, 'Lead', '2016-06-11 00:00:00'),
(003, 'Lead', '2016-06-11 00:00:00');

-- question 1
select first_name as worker_name from worker;
-- question 2
select ucase(first_name) from worker;
select upper(first_name) from worker;
-- question 3
select department from worker group by department;
select distinct department from worker;
-- question 4
select left(first_name,3)  from worker;
select substring(first_name,1,3)  from worker;
-- question 5
select  INSTR(first_name,'b') from worker where first_name='Amitabh';
-- question 6
select rtrim(first_name)from worker ;
-- question 7
select Ltrim(first_name)from worker ;
-- question 8
select distinct department ,length(department) from worker;
-- question 9
update worker set first_name= replace(first_name ,'a','A');  -- update data in table 
select replace(first_name ,'a','A') from worker; -- only prints data 
-- question 10
select concat(first_name,' ',last_name) as complete_name from worker;
-- question 11
select * from worker order by first_name asc;
-- question 12
select * from worker order by first_name asc , department desc;
-- question 13
select * from worker where first_name='Vipul'OR first_name='Satish';
select * from worker where first_name IN ('Vipul','Satish');
-- question 14
select * from worker where first_name  NOT IN ('Vipul','Satish');
-- question 15
select * from worker where department='Admin';
select * from worker where department like 'Admin%';
-- question 16
select * from worker where first_name like '%a%';
-- question 17
select * from worker where first_name like '%a';
-- question 18
select * from worker where first_name like '_____h';
-- question 19
select * from worker where salary between 100000  and 500000;
-- question 20
select * from worker where year(joining_date)=2014 AND month(joining_date)=2; 
SELECT * FROM worker WHERE joining_date BETWEEN '2014-02-01' AND '2014-02-28';
-- question 21
select department ,count(first_name) as employee_count from worker where department ='Admin';
-- question 22
select concat(first_name,' ',last_name) as full_names from worker where salary between 50000 and 100000;
-- question 23
select count(worker_id) as no_of_workers, department from worker group by department order by no_of_workers desc;
-- question 24
select w.* from worker as w inner join title as t where w.worker_id=t.worker_ref_id AND WORKER_TITLE = 'manager'; 
-- question 25
select worker_title ,count(worker_title) as count from title group by worker_title having count >1;
-- question 26
select * from worker where mod(worker_id,2)!=0;
select * from worker where mod(worker_id,2)<>0;
-- question 27
select * from worker where mod(worker_id,2)=0;
-- question 28
create table woker_clone like worker;
select * from woker_clone;
insert into woker_clone select * from worker; 
select * from woker_clone;
-- question 29
select distinct * from worker as w inner join title as t on w.worker_id=t.worker_ref_id;
-- question 30
select W.* from worker as w left join title as t on w.worker_id=t.worker_ref_id where t.worker_ref_id is null;
-- question 31
select now();
-- question 32
select * from worker order by salary desc limit 5;
-- question 33
select distinct salary from worker order by  salary desc limit 4,1;
-- question 34
SELECT salary
FROM worker w1
WHERE 5 = (
  SELECT COUNT(DISTINCT w2.salary)
  FROM worker w2
  WHERE w2.salary >= w1.salary
);
-- question 35
select w1.* from worker as w1 join worker as w2 on w1.worker_id !=w2.worker_id where w1.salary =w2.salary ;
-- question 36
select max(salary) from worker where salary not in (select max(salary) from worker);
-- question 37
select * from worker union all select * from worker order by worker_id;
-- question 38
select w.worker_id from worker as w left join bonus as b on w.worker_id=b.worker_ref_id where  b.worker_ref_id is null;
-- question 39
SELECT * 
FROM worker
WHERE RAND() <= 0.5;

select * from worker where worker_id <= ( select count(worker_id)/2 from worker);
-- question 40
select department,count(worker_id) as people from worker group by department having people<4;
-- question 41
select department,count(worker_id) as people from worker group by department ;
-- question 42
select * from worker order by worker_id desc limit 1;
select * from worker order by worker_id desc limit 0 , 1;
select * from worker where worker_id = (select max(worker_id) from worker);
-- question 43
select * from worker limit 1;
select * from worker limit 0,1;
select * from worker where worker_id = (select min(worker_id) from worker);
-- question 44
select * from worker order by worker_id desc limit 5;
-- question 45
select department,first_name,salary  from worker where salary in (select max(salary) from worker group by department);
-- question 46
select distinct salary from worker as w1 where 3>=(select count(distinct (w2.salary)) from worker as w2 where w2.salary>=w1.salary)order by salary desc;
select distinct salary from worker order by salary desc limit 3;
-- question 47
select distinct salary from worker as w1 where 3>=(select count(distinct (w2.salary)) from worker as w2 where w2.salary<=w1.salary)order by salary desc;
-- question 48
select distinct salary from worker as w1 where n>=(select count(distinct (w2.salary)) from worker as w2 where w2.salary>=w1.salary)order by salary desc;
-- question 49
select department,sum(salary) as total_salaries from worker group by department;
-- question 50
select first_name ,salary from worker where salary=(select max(salary) from worker);

