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