-- Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text. New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message confirmation to activate their account.

-- Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day.

-- Definition:

-- action_date refers to the date when users activated their accounts and confirmed their sign-up through text messages.

WITH

confirmation_date AS (
  SELECT
    email_id,
    user_id,
    signup_date + INTERVAL '1 DAY' AS signup_date_plus_1
  FROM
    emails
)

  SELECT
    c.user_id
  FROM
    confirmation_date c
  INNER JOIN
    texts t
  ON c.email_id = t.email_id
  AND c.signup_date_plus_1 = t.action_date
  AND t.signup_action = 'Confirmed'