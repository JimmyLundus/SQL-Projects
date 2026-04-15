SELECT product_name,
ROUND ((sales_price - (sales_price - purchase_price)*0.07) - purchase_price,2) AS 'Profit_Margin'
FROM products
ORDER BY Profit_Margin DESC, product_name ASC;

#Instructors Solution

SELECT product_name,
    ROUND ((sales_price - purchase_price) * 0.93, 2) AS profit
FROM products
ORDER BY profit DESC, product_name ASC;

# Alex's notes...
# CALCULATION: sales_price - purchase_price * 7 percent tax
# Output: product + Profit (rounded to 2 decimal places)
# Order on Profit DESC