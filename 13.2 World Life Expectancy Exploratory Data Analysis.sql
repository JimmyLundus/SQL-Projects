# World Life Expectancy Project (Exploratory Data Analysis)

SELECT * 
FROM world_life_expectancy
;

# We are interssted in seeing how each country has improved its life expectancy over the last 15 years
SELECT Country, 				
MIN(`Life expectancy`), # Need both min and max for each country.
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_Increase_15_Years # Take difference of MAx and Min, rounded to 1 decimal point.
FROM world_life_expectancy		 
GROUP BY Country	# initially he ordered by Country descending as well as having grouped by the country.
HAVING MIN(`Life expectancy`) <> 0		# This is filtering out some Zero Data. 
AND MAX(`Life expectancy`) <> 0			# Need to go back and Data Clean these!
ORDER BY Life_Increase_15_Years ASC
;



SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0		# He tried using Having instead of where, but got an error since Having
AND `Life expectancy` <> 0			# is only for aggreagte functions.
GROUP BY Year
ORDER BY Year
;

SELECT * 
FROM world_life_expectancy
;								# Next he is interested in seeing the correaltion between.
								# GDP and life expectancy, done as avg life expc per avg gdp per country.
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;



SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,		#1500 was chosen because it roughly the 
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy, #half way point for GDP in the data.
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy
;

SELECT * 
FROM world_life_expectancy
;

SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status		# Status is referring to if it's a developed or developing country
;


SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status
;					# This shows that there are many more developing countries
					# So the fewer number of Developed countires influences the average life expectancy more.

# Next, We are looking at BMI per country, compared to life expectancy
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0		# Filtering out any blank or zero data.
ORDER BY BMI ASC
;					# Could also look at the correalation betweeen GDP and BMI as well as life expectancy.


SELECT Country,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total # Rolliing Total is created by 
FROM world_life_expectancy														# Summing the previous data with the
WHERE Country LIKE '%United%'													# Current rolling total value.
;


















































































