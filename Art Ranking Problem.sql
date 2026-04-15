# Art Ranking Problem

# Each artist was given a rating by 3 separate judges.

# Write a query to combine those scores and rank the artists from highest to lowest. 
# If there is a tie the next ranking after it should be the next number sequentially, 
# meaning there will be a gap in the next rank.

# Output should include the artist, their total score, and rank.

# Order your output from smallest to largest rank. If there is a tie order on the artist
# id as well from smallest to largest.


#Single table named rankings that contains artist_id, judge_id, and score
# The table has multiple entries for each artist each with an individual score from each
# judge for the art from that artist. So there are multiple judges scores...
# So the very first thing we need to do is to SUM of each judges scores for each artists atrwork.
# then the rRanking if based on those scores, so we need to RANK on Scores.
# Since, if there is a tie in the ranking, and we want to have the next number after that tie
# to have the next number sequentially, which means that there will be a gap in the next rank.
# So then we will need to use RANK, NOT DENSE RANK!
# Output: artist, their total score, and rank
# Order on RANK Ascending (ASC), and secondarily on artist ID (ASC).

#Start simply...
SELECT artist_id, SUM(score)
FROM rankings
GROUP BY artist_id;


SELECT artist_id, SUM(score), 
	RANK() OVER (ORDER BY SUM(score) DESC) AS total_rating
FROM rankings
GROUP BY artist_id
ORDER BY total_rating ASC, artist_id ASC
	;











