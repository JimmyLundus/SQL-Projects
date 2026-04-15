# US Household Data Exploration

SELECT *
FROM us_project.us_household_income;

SELECT *
FROM us_project.us_household_income_statistics;

SELECT State_Name, ALand, AWater				# Area of Land, Area of Water
FROM us_project.us_household_income;

SELECT State_Name, County, City, ALand, AWater		# Here he temporarily adds in county and 
FROM us_project.us_household_income;				# city to create "Uniqueness! For insight when viewing the data.

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC;						# 2 represents the column number, so he is ordering by SUM(ALand) 

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;					# Gives the top 10 states by land area.

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 3 DESC					# Now he orders by column 3, water area: SUM(AWater)
LIMIT 10;						# Gives the top 10 states by water area.

SELECT *
FROM us_project.us_household_income u			
INNER JOIN us_project.us_household_income_statistics us	# Lookling at the two tables, each has an id column
	ON u.id = us.id;								# the id's in each table are the same, so he joins(inner)
													# the two tables based on the shared id column.
													# missing some income data and some stat data!
SELECT *
FROM us_project.us_household_income u			# so now he tries a RIGHT JOIN. (His row 31 here)
RIGHT JOIN us_project.us_household_income_statistics us	
	ON u.id = us.id
WHERE u.id IS NULL;			# Filtering on those with no data in the right table (income table)
							# Quite a few datasets didn't come in. 
                            
SELECT *								# But we are going to ignore and just use the inner join above, 
FROM us_project.us_household_income u	# but filter where MEAN is not zero.		
INNER JOIN us_project.us_household_income_statistics us	
	ON u.id = us.id
WHERE MEAN<> 0;                           
                            
SELECT u.State_Name, County, `Type`, `Primary`, Mean, Median
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN<> 0;


SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN<> 0
GROUP BY u.State_Name
ORDER BY 2				# ORDERING on the Average Household Mean Income
LIMIT 5;				# Grabbing the 5 lowest...Can invert using ORDER BY 2 DESC. and
						# LIMIT by 10 get the top 10
                        
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN<> 0
GROUP BY u.State_Name
ORDER BY 3 DESC				# ORDERING on the Average Household Meadian Income and
LIMIT 10;					# Grabbing the 10 highest...

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN<> 0
GROUP BY u.State_Name
ORDER BY 3 ASC				# ORDERING on the Average Household Meadian Income and
LIMIT 10;					# Grabbing the 10 lOWEST...

#SELECT u.State_Name, AVG(Mean), AVG(Median)
#FROM us_project.us_household_income u
#JOIN us_project.us_household_income_statistics us
#	ON u.id = us.id
#GROUP BY u.State_Name
#order by 3;


SELECT `Type`, `Primary`, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN<> 0
GROUP BY `Type`, `Primary`
order by 3;


SELECT `Type`, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)		#got rid of primary... not sure of meaning.
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN<> 0
GROUP BY `Type`
order by 2 DESC
LIMIT 10;


SELECT `Type`, COUNT(`Type`), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN<> 0
GROUP BY `Type`
order by 3 DESC
LIMIT 20;			# Municipality was disappearing with the limit 10 when counting

SELECT `Type`, COUNT(`Type`), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN<> 0
GROUP BY 1			# TYPE IS COLUMN 1
order by 4 DESC 	# Looking at the median here!
LIMIT 20;


SELECT `Type`,COUNT(`Type`), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN<> 0
GROUP BY 1						# TYPE IS COLUMN 1
HAVING COUNT(`Type`) > 100		# Filters out the small insignificat OUTLIERS, likely abbarant data
order by 4 DESC					# Municipalities was skewed since it had only one entry!
LIMIT 20;

SELECT *
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us
	ON u.id = us.id;

SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC;





SELECT u.State_Name, City, ROUND(AVG(Mean),1)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
HAVING AVG(Mean) IS NOT NULL
ORDER BY 3 ASC
LIMIT 100;



#Highest
SELECT u.State_Name, City, AVG(Mean), AVG(Median)
FROM us_project.us_household_income u
JOIN us_project.us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY 3 DESC
LIMIT 100;



