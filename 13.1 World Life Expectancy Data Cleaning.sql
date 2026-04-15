# World Life Expectancy Project (Data Cleaning)


SELECT * 
FROM world_life_expectancy
;


SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))  # Using Year and Country to Identify any duplicate data	
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;

SELECT *					# Partition by Row ID number to give duplicate entries a ROW NUMBER of 2
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),		
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE Row_Num > 1
;

DELETE FROM world_life_expectancy		# Make sure you have the original table backed up before doing this!
WHERE 
	Row_ID IN (
    SELECT Row_ID
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE Row_Num > 1)
;


SELECT * 	# Now we have to deal with any NUL data entries
FROM world_life_expectancy
WHERE Status IS NULL
;



SELECT DISTINCT(Status)		# Now we have to deal with any empty data entries
FROM world_life_expectancy
WHERE Status <> ''
;



SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing';

UPDATE world_life_expectancy					# This gave an error! Can't specify target table
SET Status = 'Developing'						# 'world_life_expectancy' for update in FROM clause
WHERE Country IN (SELECT DISTINCT(Country)
				FROM world_life_expectancy
				WHERE Status = 'Developing');


UPDATE world_life_expectancy t1					# Use this wwork around instead....!
JOIN world_life_expectancy t2					# A Self Inner Join is used to join the table t1 to itself!
	ON t1.Country = t2.Country					# Using the Self Inner Join allows us to fileter as below.
SET t1.Status = 'Developing'					# Updating table t1!
WHERE t1.Status = ''							# Update any blanks in t1 to 'Developing' and
AND t2.Status <> ''								# where t2 is not blank AND...
AND t2.Status = 'Developing'					# Where the non-blanks in t2 contain'Developing'!
;												# Also updates (ensures) that any entry in t2 that was 
												# already listed as 'Developing' remains as such.
                                                
SELECT * 
FROM world_life_expectancy
WHERE Country = 'United States of America'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;


SELECT * 
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;



# Using multiple Inner Self Joins, creating 3 tables...

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1) # Here is is taking a Rounded average of the two values above and
FROM world_life_expectancy t1							 # below the blank missing value, as a guesstimate for a new value
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2		# For updating the table we first must do the Inner Self Join
	ON t1.Country = t2.Country		#  prior to Setting the new value in t1 for the missing data.
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3. `Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;


SELECT *
FROM world_life_expectancy
#WHERE `Life expectancy` = ''
;
















