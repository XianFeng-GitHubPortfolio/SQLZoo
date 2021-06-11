-- 1. Show the lastName, party and votes for the constituency 'S14000024' in 2017.

SELECT 
   ge.lastName, ge.party, ge.votes
FROM 
   ge
WHERE 
   ge.constituency = 'S14000024' and ge.yr = 2017
ORDER BY 
   ge.votes DESC;


-- 2. You can use the RANK function to see the order of the candidates. If you RANK using (ORDER BY votes DESC) 
-- then the candidate with the most votes has rank 1.
-- Show the party and RANK for constituency S14000024 in 2017. List the output by party.

SELECT
   ge.party, ge.votes, RANK () OVER (ORDER BY ge.votes DESC) AS Ranking
FROM
  ge 
WHERE
  ge.constituency = 'S14000024' and ge.yr = 2017
GROUP BY 
   ge.party;


-- 3. The 2015 election is a different PARTITION to the 2017 election. We only care about the order of votes for each year.
-- Use PARTITION to show the ranking of each party in S14000021 in each year. Include yr, party, votes and ranking. 
-- The party with the most votes has a ranking of 1.

SELECT 
   ge.yr, 
   ge.party, 
   ge.votes,
   RANK() OVER (PARTITION BY ge.yr ORDER BY ge.votes DESC) as Ranking
FROM 
   ge
WHERE 
   ge.constituency = 'S14000021'
ORDER BY 
   ge.party, ge.yr;


-- 4. Edinburgh constituencies are numbered S14000021 to S14000026.
-- Use PARTITION BY constituency to show the ranking of each party in Edinburgh in 2017. 
-- Order your results so the winners are shown first, then ordered by constituency.

SELECT
   ge.constituency, 
   ge.party,
   ge.votes,
   RANK() OVER (PARTITION BY ge.constituency ORDER BY votes DESC) AS Ranking
FROM
   ge
WHERE
   ge.constituency BETWEEN 'S14000021' AND 'S14000026' 
   AND ge.yr = 2017
ORDER BY 
   Ranking, ge.constituency


-- 5. Show the parties that won for each Edinburgh constituency in 2017.

-- ** Solution 1: **

SELECT
   constituency, party 
FROM
   ge x
WHERE
   constituency BETWEEN 'S14000021' AND 'S14000026' 
   AND yr = 2017
   AND x.votes >= ALL(SELECT y.votes FROM ge y WHERE x.constituency = y.constituency AND yr = 2017) 
GROUP BY
   constituency;
   
 
-- ** Solution 2: ** 
 
SELECT 
   constituency, party 
FROM 
   (
    SELECT
       ge.constituency, 
       ge.party,
       ge.votes,
       RANK() OVER (PARTITION BY ge.constituency ORDER BY votes DESC) AS Ranking
    FROM
       ge
    WHERE
       ge.constituency BETWEEN 'S14000021' AND 'S14000026' 
    AND ge.yr = 2017
   ) AS T
WHERE 
   Ranking = 1;
   
   
-- 6. You can use COUNT and GROUP BY to see how each party did in Scotland. Scottish constituencies start with 'S'
-- Show how many seats for each party in Scotland in 2017.

SELECT 
   party, COUNT(party) AS no_of_seats
FROM 
   (
    SELECT
       ge.constituency, 
       ge.party,
       ge.votes,
       RANK() OVER (PARTITION BY ge.constituency ORDER BY votes DESC) AS Ranking
    FROM
       ge
    WHERE
       ge.constituency LIKE 'S%'AND ge.yr = 2017
    ) AS T
WHERE 
   Ranking = 1
GROUP BY
   party;
