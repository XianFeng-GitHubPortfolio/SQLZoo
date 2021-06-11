-- 1. Change the query shown so that it displays Nobel prizes for 1950.

SELECT 
   nobel.yr, nobel.subject, nobel.winner
FROM 
   nobel
WHERE 
   yr = 1950;


-- 2. Show who won the 1962 prize for Literature.

SELECT
   nobel.winner
FROM 
   nobel
WHERE
   nobel.yr = 1962 AND nobel.subject = 'Literature';
   

-- 3. Show the year and subject that won 'Albert Einstein' his prize.

SELECT
   nobel.yr, nobel.subject
FROM 
   nobel
WHERE
   nobel.winner = 'Albert Einstein';


-- 4. Give the name of the 'Peace' winners since the year 2000, including 2000.

SELECT
   nobel.winner
FROM 
   nobel
WHERE
   nobel.subject = 'Peace' AND nobel.yr >= 2000;
  
  
-- 5. Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.

SELECT
   *
FROM 
   nobel 
WHERE
   nobel.subject = 'Literature' AND nobel.yr BETWEEN 1980 AND 1989;
   

-- 6. Show all details of the presidential winners: Theodore Roosevelt, Woodrow Wilson, Jimmy Carter, Barack Obama.

SELECT
   *
FROM 
   nobel 
WHERE
   nobel.winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');
   

-- 7. Show the winners with first name John.

SELECT 
   nobel.winner
FROM 
   nobel
WHERE
   nobel.winner LIKE 'John%';
   

-- 8. Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.

SELECT
   *
FROM 
   nobel
WHERE
   (nobel.subject = 'Physics' AND nobel.yr = 1980) OR
   (nobel.subject = 'Chemistry' AND nobel.yr = 1984)


-- 9. Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine.

SELECT
   *
FROM 
   nobel 
WHERE
   nobel.yr = 1980 AND nobel.subject != 'Chemistry' AND nobel.subject != 'Medicine';
   

-- 10. Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) 
-- together with winners of a 'Literature' prize in a later year (after 2004, including 2004).

SELECT
   * 
FROM
   nobel 
WHERE
   (nobel.subject = 'Medicine' AND nobel.yr < 1910) OR (nobel.subject = 'Literature' AND nobel.yr >= 2004);


-- 11. Find all details of the prize won by PETER GRÜNBERG.

SELECT
   * 
FROM 
   nobel 
WHERE
   nobel.winner = 'PETER GRÜNBERG';

-- (For windows users, press Alt+0220 to type the Umlaut symbol.)


-- 12. Find all details of the prize won by EUGENE O'NEILL.

SELECT
   *
FROM 
   nobel
WHERE
   nobel.winner = 'EUGENE O''NEILL';


-- 13. List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.

SELECT
   nobel.winner, nobel.yr, nobel.subject 
FROM 
   nobel
WHERE
   nobel.winner LIKE 'Sir%'
ORDER BY 
   nobel.yr DESC, nobel.winner;


-- 14. The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
-- Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.

SELECT 
   nobel.winner, nobel.subject
FROM 
   nobel
WHERE 
   nobel.yr = 1984
ORDER BY 
    nobel.subject IN ('Physics','Chemistry'), nobel.subject, nobel.winner;
