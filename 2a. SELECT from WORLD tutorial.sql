-- 1. Show the name, continent and population of all countries.

SELECT 
   world.name, world.continent, world.population 
FROM 
   world;


-- 2. Show the name for the countries that have a population of at least 200 million. 

SELECT 
   world.name
FROM 
   world
WHERE  
   world.population > 200000000;
   
 
 -- 3. Give the name and the per capita GDP for those countries with a population of at least 200 million.
 
SELECT
   world.name, world.gdp/world.population
FROM 
   world
WHERE
   world.population > 200000000;
   
 
 -- 4. Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.

SELECT
   world.name, world.population/1000000 
FROM 
   world
WHERE 
   world.continent = 'South America';
   
 
-- 5. Show the name and population for France, Germany, Italy.

SELECT
   world.name, world.population 
FROM
   world
WHERE 
   world.name IN ('France', 'Germany', 'Italy');


-- 6. Show the countries which have a name that includes the word 'United'.

SELECT
   world.name
FROM
   world
WHERE
   world.name LIKE '%United%';


-- 7. A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
-- Show the countries that are big by area or big by population. Show name, population and area.

SELECT
   world.name, world.population, world.area 
FROM
   world
WHERE
   world.area > 3000000 OR world.population > 250000000;
   
-- 8. Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. 
-- Show name, population and area.

SELECT
   world.name, world.population, world.area 
FROM
   world
WHERE
   world.area > 3000000 XOR world.population > 250000000;
   
   
-- 9. Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'.
-- Use the ROUND function to show the values to two decimal places.

SELECT
   world.name, ROUND(world.population/1000000,2), ROUND(world.gdp/1000000000,2) 
FROM
   world
WHERE
   world.continent = 'South America';


-- 10. Show per-capita GDP for the trillion dollar countries to the nearest $1000.

SELECT
   world.name, ROUND(world.gdp/world.population,-3)
FROM 
   world
WHERE
   world.gdp > 1000000000000;


-- 11. Show the name and capital where the name and the capital have the same number of characters.

SELECT
   world.name, world.capital 
FROM 
   world
WHERE
   LENGTH(world.name) = LENGTH(world.capital);
   

-- 12. Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.

SELECT
   world.name, world.capital 
FROM 
   world
WHERE 
   LEFT(world.name,1) = LEFT(world.capital,1) AND world.name <> world.capital;


-- 13. Find the country that has all the vowels and no spaces in its name.

SELECT
   world.name
FROM
   world
WHERE
   world.name LIKE '%a%' AND 
   world.name LIKE '%e%' AND
   world.name LIKE '%i%' AND 
   world.name LIKE '%o%' AND 
   world.name LIKE '%u%' AND
   world.name NOT LIKE '% %';1. Show the name, continent and population of all countries.
