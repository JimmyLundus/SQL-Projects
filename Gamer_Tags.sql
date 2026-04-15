SELECT YEAR (birth_date) AS Birth_Year
SELECT LEFT (first_name,3) AS Truncname
FROM gamer_tags;

SELECT YEAR (birth_date) AS Birth_Year, LEFT (first_name,3) AS Truncname
FROM gamer_tags;


CONCAT (Truncname) || (Birth_Year)

SELECT first_name,birth_date
SUBSTRING(first_name, 1,3),
SUBSTRING(birth_date, 9,10), 
FROM gamer_tags;
CONCAT(SUBSTRING(first_name,1,3); 

Final Correct Solution is below:

SELECT first_name, last_Name,
CONCAT(LEFT(first_name, 3), LEFT(birth_date, 4)) AS gamer_tag
FROM gamer_tags
ORDER BY gamer_tag ASC;

# Another correct solution ( From the Instructor ) is below
SELECT First_Name, Last_Name, 
  CONCAT(LEFT(First_Name, 3), YEAR(Birth_Date)) AS gamer_tag
FROM gamer_tags
ORDER BY gamer_tag;

