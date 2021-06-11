-- 1. The example uses a WHERE clause to show the cases in 'Italy' in March.
-- Modify the query to show data from Spain.

SELECT 
   covid.name, DAY(covid.whn), covid.confirmed, covid.deaths, covid.recovered
FROM 
   covid
WHERE 
   covid.name = 'Spain' AND MONTH(covid.whn) = 3
ORDER BY 
   covid.whn;
   

-- 2. The LAG function is used to show data from the preceding row or the table. 
-- When lining up rows the data is partitioned by country name and ordered by the data whn. 
-- That means that only data from Italy is considered.
-- Modify the query to show confirmed for the day before.

SELECT 
   covid.name, 
   DAY(covid.whn), 
   covid.confirmed,
   LAG(covid.confirmed, 1) OVER (PARTITION BY covid.name ORDER BY covid.whn) AS dbf
FROM 
   covid
WHERE 
   covid.name = 'Italy'AND MONTH(covid.whn) = 3
ORDER BY 
   covid.whn;
   
   
-- 3. The number of confirmed case is cumulative - but we can use LAG to recover the number of new cases reported for each day.
-- Show the number of new cases for each day, for Italy, for March.

SELECT 
   covid.name,  
   DAY(covid.whn), 
   covid.confirmed - LAG(covid.confirmed, 1) OVER (PARTITION BY covid.name ORDER BY covid.whn) AS new_cases
FROM 
   covid
WHERE 
   covid.name = 'Italy' AND MONTH(covid.whn) = 3
ORDER BY 
   covid.whn;


-- 4. The data gathered are necessarily estimates and are inaccurate. However by taking a longer time span 
-- we can mitigate some of the effects.You can filter the data to view only Monday's figures WHERE WEEKDAY(whn) = 0.
-- Show the number of new cases in Italy for each week - show Monday only.

SELECT 
   covid.name, 
   DATE_FORMAT(covid.whn,'%Y-%m-%d') AS week, 
   covid.confirmed - LAG(covid.confirmed,1) OVER (PARTITION BY covid.name ORDER BY covid.whn) AS new_cases
FROM 
   covid
WHERE 
   covid.name = 'Italy' AND WEEKDAY(covid.whn) = 0
ORDER BY 
   covid.whn
   

-- 5. You can JOIN a table using DATE arithmetic. This will give different results if data is missing.
-- Show the number of new cases in Italy for each week - show Monday only.
-- In the sample query we JOIN this week tw with last week lw using the DATE_ADD function.

SELECT 
   tw.name, 
   DATE_FORMAT(tw.whn,'%Y-%m-%d'), 
   tw.confirmed - lw.confirmed AS new_cases
FROM 
   covid AS tw LEFT JOIN covid AS lw ON (DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn AND tw.name=lw.name)
WHERE 
   tw.name = 'Italy' AND WEEKDAY(tw.whn) = 0
ORDER BY 
   tw.whn
   

-- 6. The query shown shows the number of confirmed cases together with the world ranking for cases.
-- United States has the highest number, Spain is number 2.
-- Notice that while Spain has the second highest confirmed cases, Italy has the second highest number of deaths due to the virus.
-- Include the ranking for the number of deaths in the table.

SELECT 
   covid.name,
   covid.confirmed,
   RANK() OVER (ORDER BY covid.confirmed DESC) AS case_ranking,
   covid.deaths,
   RANK() OVER (ORDER BY covid.deaths DESC) AS death_ranking
FROM 
   covid
WHERE 
   covid.whn = '2020-04-20'
ORDER BY 
   covid.confirmed DESC
   

-- 7. The query shown includes a JOIN t the world table so we can access the total population of each country and 
-- calculate infection rates (in cases per 100,000).
-- Show the infect rate ranking for each country. Only include countries with a population of at least 10 million.

SELECT 
   world.name,
   ROUND(100000*covid.confirmed/world.population,0) AS rate, 
   RANK() OVER (ORDER BY covid.confirmed/world.population) as ranking
FROM 
   covid JOIN world ON covid.name = world.name
WHERE 
   covid.whn = '2020-04-20' AND world.population > 10000000
ORDER BY 
   world.population DESC;
   

-- 8. For each country that has had at last 1000 new cases in a single day, show the date of the peak number of new cases.

WITH 
C1 AS
(SELECT 
    covid.name, 
    DATE_FORMAT(covid.whn, "%Y-%m-%d") as date,
    covid.confirmed - LAG(covid.confirmed,1) OVER (PARTITION BY covid.name ORDER BY DATE(covid.whn)) as new_cases
 FROM 
    covid
 ORDER BY 
    covid.whn
),

C2 AS
(SELECT 
    C1.name, 
    MAX(C1.new_cases) as max_new_cases
 FROM 
    C1
 WHERE 
    C1.new_cases >= 1000
 GROUP BY 
    C1.name
 ORDER BY 
    C1.date
)

SELECT
   C1.name, C1.date, C2.max_new_cases AS PeakNewCases
FROM 
   C1 JOIN C2 ON C1.name = C2.name AND C1.new_cases = C2.max_new_cases
ORDER BY
  C1.date

--   Create C1 which contains a column for new cases each day. 
--   Create C2 by filtering C1 for countries with at least 1000 new cases in a single day
--   and creating a column that has the max number of new cases in a day for each eligible country.
--   Join C1 and C2 on the name and case numbers (max new cases in a single day = new cases) and display desired results.      
