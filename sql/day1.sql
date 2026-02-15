#Table: Employee

#+-------------+------+
#| Column Name | Type |
#+-------------+------+
#| id          | int  |
#| salary      | int  |
#+-------------+------+
#id is the primary key (column with unique values) for this table.
#Each row of this table contains information about the salary of an employee.

#Write a solution to find the second highest distinct salary from the Employee table. 
#If there is no second highest salary, return null (return None in Pandas).

# Write your MySQL query statement below
select coalesce (    
    (select distinct salary 
    from (
        select 
            salary,
            dense_rank() over (order by salary desc) as rnk
        from
            employee
    )   t
    where t.rnk = 2),
    null)
as SecondHighestSalary;

#Write a solution to find the nth highest distinct salary from the Employee table.
#If there are less than n distinct salaries, return null.

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
        select 
            distinct salary
        from (
            select
                salary,
                dense_rank() over (order by salary desc) as rnk
            from
                Employee
        )   as t
        where t.rnk = N
  );
END

#Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:

#The scores should be ranked from the highest to the lowest.
#If there is a tie between two scores, both should have the same ranking.
#After a tie, the next ranking number should be the next consecutive integer value. 
#In other words, there should be no holes between ranks.
#Return the result table ordered by score in descending order.

# Write your MySQL query statement below
select 
    score,
    dense_rank() over (order by score desc) as 'rank'
from
    Scores;

#Table: Logs
#+-------------+---------+
#| Column Name | Type    |
#+-------------+---------+
#| id          | int     |
#| num         | varchar |
#+-------------+---------+
#In SQL, id is the primary key for this table.
#id is an autoincrement column starting from 1.
 
#Find all numbers that appear at least three times consecutively.
#Return the result table in any order.
#The result format is in the following example.

# Write your MySQL query statement below
select
    num as ConsecutiveNums
from
    (
        select 
            num,
            count(*) as NumCount
        from 
            Logs
        group by
            num
        order by
            num
    ) as NumSummary
where NumCount >= 3;

#Write a solution to find employees who have the highest salary in each of the departments.
#Return the result table in any order.

SELECT
    Department,
    Employee,
    Salary
FROM
    (
        SELECT
            e.name as Employee,
            d.name as Department,
            e.salary as Salary
            dense_rank() OVER (PARTITION BY d.name ORDER BY e.salary DESC) as rnk
        FROM
            employee e,
            JOIN department d
            ON e.departmentId = d.id
    ) as temp
WHERE rnk = 1;