SELECT USER_ID, AVG(MINUTES_PER_SESSION) average_time_gaming # don't select activity, or it will end up in the output.
FROM sessions
WHERE activity = 'Gaming'
GROUP BY user_id


# need the AVG minutes per session
# need to filter : activity is Gaming
# Group BY user_id