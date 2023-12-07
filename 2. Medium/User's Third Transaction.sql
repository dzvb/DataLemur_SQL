-- Assume you are given the table below on Uber transactions made by users.
-- Write a query to obtain the third transaction of every user.
-- Output the user id, spend and transaction date.

WITH
  temp AS (
    SELECT
      *,
      ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS n_trans
    FROM
      transactions
  )
  
SELECT
  user_id,
  spend,
  transaction_date
FROM
  temp
WHERE
  n_trans = 3