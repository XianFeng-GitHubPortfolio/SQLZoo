-- 1. Show the percentage who STRONGLY AGREE. 

SELECT nss.A_STRONGLY_AGREE
  FROM nss
 WHERE nss.question='Q01'
   AND nss.institution='Edinburgh Napier University'
   AND nss.subject='(8) Computer Science';


-- 2. Show the institution and subject where the score is at least 100 for question 15.

SELECT 
   nss.institution, nss.subject
FROM 
   nss
WHERE
   nss.question = 'Q15' AND nss.score >= 100;


-- 3. Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15'.

SELECT
   nss.institution, nss.score 
FROM 
   nss
WHERE
   nss.subject = '(8) Computer Science'
   AND nss.question = 'Q15'
   AND nss.score < 50; 
           

-- 4. Show the subject and total number of students who responded to question 22 for each of the 
subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

SELECT
   nss.subject, sum(nss.response) 
FROM 
   nss
WHERE
   (nss.subject = '(8) Computer Science' OR nss.subject = '(H) Creative Arts and Design')
   AND nss.question = 'Q22' 
GROUP BY
   nss.subject;


-- 5. Show the subject and total number of students who A_STRONGLY_AGREE to question 22 for each of the subjects 
-- '(8) Computer Science' and '(H) Creative Arts and Design'.

SELECT
   nss.subject, SUM(nss.A_STRONGLY_AGREE/100*nss.response) AS response
FROM
   nss
WHERE
   (nss.nss.subject = '(8) Computer Science' OR nss.subject = '(H) Creative Arts and Design')
   AND nss.question = 'Q22'
GROUP BY
   vsubject;


-- 6. Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject 
-- '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'.

SELECT
   nss.subject, ROUND(SUM(nss.A_STRONGLY_AGREE/100*nss.response)/SUM(nss.response)*100)
FROM
   nss
WHERE
   (nss.subject = '(8) Computer Science' OR nss.subject = '(H) Creative Arts and Design')
   AND nss.question = 'Q22'
GROUP BY
   nss.subject;


-- 7. Show the average scores for question 'Q22' for each institution that include 'Manchester' in the name.

SELECT
   nss.institution, ROUND(SUM(nss.score*nss.response)/SUM(nss.response))
FROM 
   nss
WHERE
   nss.institution LIKE '%Manchester%' AND nss.question = 'Q22'
GROUP BY
   nss.institution;
   

-- 8. Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'.

SELECT
   nss.institution, 
   SUM(nss.sample) AS sample_size,
   SUM(CASE WHEN nss.subject = '(8) Computer Science' THEN nss.sample ELSE 0 END) AS comp_students
FROM
   nss
WHERE
   nss.question = 'Q01'
   AND nss.institution LIKE '%Manchester%'
GROUP BY
   nss.institution;
