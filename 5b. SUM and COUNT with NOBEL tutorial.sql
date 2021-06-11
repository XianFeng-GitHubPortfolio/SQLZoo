-- 1. Show the total number of prizes awarded.

SELECT 
   COUNT(nobel.winner) 
FROM 
   nobel;


-- 2. List each subject - just once.

SELECT 
   DISTINCT(nobel.subject)
FROM
   nobel;


-- 3. Show the total number of prizes awarded for Physics.

SELECT
   COUNT(nobel.winner)
FROM 
   nobel
WHERE
   nobel.subject = 'Physics';
   

-- 4. For each subject show the subject and the number of prizes.

SELECT
   nobel.subject, COUNT(nobel.winner)
FROM 
   nobel
GROUP BY 
   nobel.subject;


-- 5. For each subject show the first year that the prize was awarded.

SELECT
   nobel.subject, MIN(nobel.yr)
FROM 
   nobel
GROUP BY 
   nobel.subject;


-- 6. For each subject show the number of prizes awarded in the year 2000.

SELECT
   nobel.subject, COUNT(nobel.winner) 
FROM 
   nobel
WHERE
   nobel.yr = 2000
GROUP BY 
   nobel.subject;


-- 7. Show the number of different winners for each subject.

SELECT
   nobel.subject, COUNT(DISTINCT nobel.winner)
FROM
   nobel
GROUP BY 
   nobel.subject;


-- 8. For each subject show how many years have had prizes awarded.

SELECT
   nobel.subject, COUNT(DISTINCT nobel.yr)
FROM 
   nobel
GROUP BY 
   nobel.subject;


-- 9. Show the years in which three prizes were given for Physics.

SELECT
   nobel.yr
FROM 
   nobel
WHERE
   nobel.subject = 'Physics'
GROUP BY 
   nobel.yr
HAVING 
   COUNT(nobel.winner) = 3;


-- 10. Show winners who have won more than once.

SELECT
   nobel.winner 
FROM 
   nobel
GROUP BY 
   nobel.winner
HAVING
   COUNT(nobel.winner) > 1;


-- 11. Show winners who have won more than one subject.

SELECT
   nobel.winner
FROM 
   nobel
GROUP BY 
   nobel.winner
HAVING 
   COUNT(DISTINCT nobel.subject) > 1;


-- 12. Show the year and subject where 3 prizes were given. Show only years 2000 onwards.

SELECT
   nobel.yr, nobel.subject
FROM
   nobel
WHERE
   nobel.yr >= 2000
GROUP BY 
   nobel.yr, nobel.subject
HAVING 
   COUNT(nobel.winner) = 3;
