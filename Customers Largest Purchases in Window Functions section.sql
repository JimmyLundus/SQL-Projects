#Customers Largest Purchases in Window Functions section
#We want to take a look at each customers purchases and give them their own row number.
#Break the rows out by the customer and give each row a number based off the amount 
#spent starting from the highest to the lowest.
# There is just one table...'purchases'
#it contains a 'customer_id', a 'transaction_id' and an 'amount' for each transaction.
# We need to organize the output by row numbers, and arrange the rows based on the amout spent,
# from highest to lowest.


SELECT customer_id, transaction_id, amount
FROM (purchases)
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY amount DESC) AS row_num
FROM purchases;

# Correct answer below:
SELECT customer_id, amount,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY amount DESC) AS row_num
FROM purchases;