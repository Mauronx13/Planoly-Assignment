-- 1. Which are the top 10 account ids by number of users?
SELECT TOP 10 account_id as "Account ID", COUNT(user_id) as "Number of Users"
FROM tasks_used_da
GROUP BY account_id
ORDER BY COUNT(user_id) DESC;

-- 2. Create a summary table at the account level that signals when an account is new (boolean). An account is new for the first day we see it run a task(s).

-- Create table to sum all the tasks at the account level per day (This will be used for Question 3 too)
CREATE TABLE maponte.account_level AS
SELECT date, account_id, sum(sum_tasks_used) as tasks
FROM tasks_used_da
GROUP BY 1,2;

-- Create summary table
CREATE TABLE summary_newaccounts AS
WITH first_day AS 
    (SELECT * FROM (SELECT date, account_id, tasks, rank() OVER (PARTITION BY account_id ORDER BY date, tasks) AS account
    FROM account_level 
    WHERE tasks > 0
    ORDER BY account_id, date ) as task
    WHERE account = 1)
    
SELECT act.date, act.account_id, tasks,
CASE WHEN tasks IN (SELECT tasks FROM first_day WHERE account_id = act.account_id AND date = act.date) THEN 'T' ELSE 'F' END AS "New Account?"
FROM account_level act
GROUP BY date, account_id, tasks
ORDER BY 1, 2 ASC;

-- 3. Create a summary table at the account level. Add a column with the % difference in the number of tasks to the previous day (feel free to reuse the previous).

CREATE TABLE maponte.summary_tasksdifference AS
WITH previous_task AS  
	(SELECT date, account_id, tasks, lag(tasks,1) OVER (PARTITION BY account_id ORDER BY date) previous
 	FROM account_level 
 	ORDER BY account_id, date)
 
SELECT date, account_id, tasks, 
CASE WHEN tasks <> 0 THEN ((tasks - previous) * 100 / tasks) ELSE NULL END as "Difference (%) to Previous Date"
FROM previous_task
ORDER BY account_id, date;

-- 4. Add another column with the moving average of tasks run in the last 7 days of each account.

SELECT date, account_id, tasks, difference_to_previous_date, ROUND(AVG(tasks) OVER (PARTITION BY account_id ORDER BY account_id, date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)::DECIMAL,2) AS "7day_moving_average"
FROM summary_tasksdifference
ORDER BY account_id, date;

-- 5. A lost account is an account with no tasks run on a given month. How many accounts did we lose (had no executed tasks) in February 2017?
SELECT count(DISTINCT account_id) AS "Lost Accounts"
FROM tasks_used_da
WHERE sum_tasks_used = '0' 
AND date BETWEEN '2017-02-01' AND '2017-02-28';