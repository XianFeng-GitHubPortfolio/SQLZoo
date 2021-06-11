-- 1. Show the total population of the world. 

SELECT 
   SUM(world.population)
FROM 
   world;


-- 2. List all the continents - just once each.

SELECT 
   DISTINCT world.continent
FROM 
   world;


-- 3. Give the total GDP of the Africa.

SELECT
   SUM(world.gdp)
FROM
   world
WHERE
   world.continent = 'Africa';


-- 4. How many countries have an area of at least 1000000?

SELECT
   COUNT(world.name)
FROM
   world
WHERE
   world.area > 1000000;
   

-- 5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')?

SELECT
   SUM(world.population) 
FROM 
   world
WHERE
   world.name IN ('Estonia', 'Latvia', 'Lithuania');


-- 6. For each continent, show the continent and number of countries.

SELECT
   world.continent, COUNT(world.name) 
FROM 
   world
GROUP BY
   world.continent;


-- 7. For each continent, show the continent and number of countries with populations of at least 10 million.

SELECT
   world.continent, COUNT(world.name)
FROM
   world
WHERE 
   world.population > 10000000
GROUP BY
   world.continent;


-- 8. List the continents that have a total population of at least 100 million.

SELECT
   world.continent
FROM
   world
GROUP BY 
   world.continent
HAVING 
   SUM(world.population) > 100000000;
