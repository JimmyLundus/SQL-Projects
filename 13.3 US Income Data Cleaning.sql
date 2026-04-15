# US Household Income Data CLeaning

SELECT*
FROM us_project.us_household_income;

SELECT* 
FROM us_project.us_household_income_statistics;

ALTER TABLE us_project.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`; # Needed to fix the 
																					 # First column name
SELECT*
FROM us_project.us_household_income;

SELECT COUNT(id)								 # Do a count of id's after altering
FROM us_project.us_household_income_statistics;  # We are missing about 230 rows of data. 
# Looking over data, some states are not capitalized, 
# in statistics some states are missing income data
SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;				# Checking for duplicates!
# Use Row ID to remove duplicates
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id)
FROM us_project.us_household_income;
# Want to filter on where it's greater than 2, but really can't 
# because it's in the column we created in line 25 (ROW_NUMBER() OVER(PARTITION BY id ORDER BY id))
# so we need to do a subqueery

SELECT*
FROM(
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num	#give this the name row_num
FROM us_project.us_household_income
) duplicates		# He had to add the word duplicates to get rid of an error
WHERE row_num > 1	# It's needed to capture/ display the duplicates identified per the Where statement
;

DELETE FROM	us_household_income		# USING THE ABOVE AS OUR SUBQUEERY
WHERE row_id IN(
	SELECT row_id
		FROM(
			SELECT row_id,
			id,
			ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num	# give this the name row_num
			FROM us_project.us_household_income
			) duplicates		# He had to add the word duplicates to get rid of an error
		WHERE row_num > 1)	# It's needed to capture/ display the duplicates identified per the Where statement
;

#Go back and check.... run code at lines 31-39. We see the duplicates are now gone
# Now we want to check the stats table for duplicATES

SELECT id, COUNT(id)
FROM us_project.us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1;				# Checking for duplicates! No duplicates found in the stats table.

# Previously we noticed some spelling errors in the states names...So we need to fix this
SELECT State_Name, COUNT(State_Name)
FROM us_project.us_household_income
GROUP BY State_Name;					# It appears that My Sequel has fixed some of the spelling errors ( Alabama)
										# but there is still one georgia. But this is not good, we need to
										#see where the errors are in the raw data.
SELECT DISTINCT State_Name  # So he went back and used SELECT DISTINCT State_name
FROM us_project.us_household_income     # And we see just the one misspelling of georia
ORDER BY 1;								# Even with the Order By 1 statement, there are no others found
										# But he is still concerned by the previous misspellings of Alabama...
UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

# Let's check state abbreviations
SELECT DISTINCT State_ab  
FROM us_project.us_household_income     
ORDER BY 1;							# Looks good!

# Checking on the Column 'Place'
SELECT *  
FROM us_project.us_household_income
WHERE Place = ''     
ORDER BY 1;							# There is one entry that is empty, Row 32.					
									# It's in Autauga County, AND City of Vinemont
SELECT *  
FROM us_project.us_household_income
WHERE Place = 'Autauga County'     
ORDER BY 1;	

#Fix as per below....ALTER
UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';
#Check it. And it worked!
SELECT *  
FROM us_project.us_household_income
;	

# Next he checks the column entitled "Type'
SELECT Type, COUNT(Type)  
FROM us_project.us_household_income
GROUP BY Type
#ORDER BY 1		# There are different types..Some data type look like they have been 
	;				# split through typ[ographical errors. CPD should likely be with CDP, but we can't be certain. 
                    # Bouroughs should likely be with Bourough. Just change Bourough/s.
                    
UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'; 	#Checked using line 106, and the change was made.

# Next we want to look at ALand and AWater.
# and check for blank or null data.
SELECT DISTINCT AWater
FROM us_project.us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
;													#No blank or NULL AWater data
# Let's do the same for the ALand Data column
SELECT DISTINCT ALand, AWater
FROM us_project.us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL)
	;
# Let's look at the conmbo when just ALand might be Zero  
SELECT DISTINCT ALand, AWater
FROM us_project.us_household_income
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
	;     

  # Let's look at the conmbo when just AWater might be Zero  
SELECT DISTINCT ALand, AWater
FROM us_project.us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
	; 
    # Data looks fairly clean now.