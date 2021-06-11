-- 1. List each country name where the population is larger than that of 'Russia'.

SELECT
   world.name 
FROM 
   world
WHERE 
   world.population > (SELECT world.population 
                       FROM world 
                       WHERE world.name = 'Russia');


-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT
   world.name
FROM
   world
WHERE world.gdp/world.population > (SELECT world.gdp/world.population 
                                    FROM world 
                                    WHERE world.name = 'United Kingdom')     
      AND world.continent = 'Europe';


-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT
   world.name, world.continent 
FROM 
   world
WHERE 
   world.continent IN (SELECT world.continent 
                       FROM world
                       WHERE world.name IN ('Argentina', 'Australia')) 
ORDER BY 
   world.name;


-- 4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.

SELECT
   world.name, world.population
FROM
   world
WHERE 
   world.population > (SELECT world.population 
                       FROM world 
                       WHERE world.name = 'Canada')
   AND world.population < (SELECT world.population 
                           FROM world 
                           WHERE world.name = 'Poland');


-- 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT
   world.name, 
   CONCAT(ROUND(100*world.population/(SELECT world.population FROM world WHERE world.name = 'Germany')),'%')
FROM 
   world 
WHERE
   world.continent = 'Europe';


-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values.)

SELECT
   world.name
FROM 
   world 
WHERE 
   world.gdp > ALL(SELECT world.gdp
                   FROM world
                   WHERE world.gdp > 0
                         AND world.continent = 'Europe');


-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area.

SELECT
   continent, name, area
FROM 
   world x
WHERE
   x.area >= ALL(SELECT y.area 
                 FROM world y 
                 WHERE x.continent = y.continent);


-- 8. List each continent and the name of the country that comes first alphabetically.

SELECT 
   continent, name 
FROM 
   world x
WHERE 
   x.name <= ALL (SELECT y.name 
                  FROM world y 
                  WHERE x.continent = y.continent);


-- 9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these 
   continents. Show name, continent and population.

SELECT
   name, continent, population
FROM 
   world x
WHERE 
   25000000 >= ALL(SELECT y.population 
                   FROM world y 
                   WHERE x.continent = y.continent);
 
 
 -- 10. Some countries have populations more than three times that of any of their neighbours (in the same continent). 
     Give the countries and continents.

SELECT
   name, continent 
FROM 
   world x
WHERE 
   x.population/3 > ALL(SELECT y.population 
                        FROM world y 
                        WHERE x.continent = y.continent
                              AND x.name <> y.name);
