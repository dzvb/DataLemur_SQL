-- New TikTok users sign up with their emails. They confirmed their signup by replying to the text confirmation to activate their accounts. Users may receive multiple text messages for account confirmation until they have confirmed their new account.

-- A senior analyst is interested to know the activation rate of specified users in the emails table. Write a query to find the activation rate. Round the percentage to 2 decimal places.

-- Definitions:

-- emails table contain the information of user signup details.
-- texts table contains the users' activation information.
-- Assumptions:

-- The analyst is interested in the activation rate of specific users in the emails table, which may not include all users that could potentially be found in the texts table.
-- For example, user 123 in the emails table may not be in the texts table and vice versa.
-- 'Confirmed' in signup_action means the user has activated their account and successfully completed the signup process.

WITH

activated AS (
  SELECT
    COUNT(*) AS n_activated
  FROM
    emails
  WHERE
    email_id IN (SELECT email_id FROM texts WHERE signup_action = 'Confirmed')
),

total_emails AS (
  SELECT
    COUNT(*) AS n_total
  FROM
    emails
)

SELECT ROUND(1.0 * n_activated / n_total, 2) AS confirm_rate
FROM activated, total_emails