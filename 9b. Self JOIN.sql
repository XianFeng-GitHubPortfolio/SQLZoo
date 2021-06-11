-- 1. How many stops are in the database?

SELECT
   COUNT(*) 
FROM 
   stops;
   

-- 2. Find the id value for the stop 'Craiglockhart'.

SELECT
   stops.id
FROM 
   stops
WHERE
   stops.name = 'Craiglockhart';
   

-- 3. Give the id and the name for the stops on the '4' 'LRT' service.

SELECT
   stops.id, stops.name 
FROM 
   stops JOIN route ON stops.id = route.stop
WHERE 
   route.num = '4' AND route.company = 'LRT' 


-- 4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). 
-- Run the query and notice the two services that link these stops have a count of 2. 
-- Add a HAVING clause to restrict the output to these two routes.

SELECT 
   route.company, route.num, COUNT(*)
FROM 
   route 
WHERE 
   route.stop=149 OR route.stop=53
GROUP BY 
   route.company, route.num
HAVING 
   COUNT(*) > 1;


-- 5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, 
-- without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.

SELECT 
   a.company, a.num, a.stop, b.stop
FROM 
   route AS a JOIN route AS b ON (a.company = b.company AND a.num = b.num)
WHERE 
   a.stop = 53 AND b.stop = 149;
   

-- 6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer 
-- to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' 
-- are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'.

SELECT 
   a.company, a.num, stopa.name, stopb.name
FROM 
   route AS a JOIN route AS b ON (a.company = b.company AND a.num = b.num)
              JOIN stops AS stopa ON (a.stop = stopa.id)
              JOIN stops AS stopb ON (b.stop = stopb.id)
WHERE 
   stopa.name='Craiglockhart' AND stopb.name = 'London Road';


-- 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith').

SELECT DISTINCT
   a.company, a.num
FROM 
   route AS a JOIN route AS b ON (a.company = b.company AND a.num = b.num)
WHERE 
   a.stop = 115 AND b.stop = 137;
   
   
-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'.

SELECT
   a.company, a.num 
FROM 
   route AS a JOIN route AS b ON (a.company = b.company AND a.num = b.num)
              JOIN stops AS stopa ON (a.stop = stopa.id) 
              JOIN stops AS stopb ON (b.stop = stopb.id)
WHERE
  stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross';


-- 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, 
-- including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.

SELECT DISTINCT
   stopb.name, a.company, a.num 
FROM 
   route AS a JOIN route AS b ON (a.company = b.company AND a.num = b.num)
              JOIN stops AS stopa ON (a.stop = stopa.id) 
              JOIN stops AS stopb ON (b.stop = stopb.id)
WHERE
   stopa.name = 'Craiglockhart';


-- 10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.


-- Solution 1

SELECT 
   a.num, a.company, stopb.name, d.num, d.company
FROM 
   route AS a JOIN route AS b ON (a.company = b.company AND a.num = b.num)
           JOIN route AS c ON (b.stop = c.stop)
           JOIN route AS d ON (d.company = c.company AND c.num = d.num)
           JOIN stops AS stopa ON a.stop = stopa.id
           JOIN stops AS stopb ON b.stop = stopb.id
           JOIN stops AS stopc ON c.stop = stopc.id
           JOIN stops AS stopd ON d.stop = stopd.id
WHERE 
   stopa.name = 'Craiglockhart' AND stopd.name = 'Lochend'
ORDER BY 
   a.num, a.company, stopb.name, d.num, d.company;
 
--  To get from Cragilockhart to Lochend with two buses, we can think of the journey as a 3 step process:
--  Craiglockhart (route a) to transfer point (route b) 
--  Change from bus 1 (route b) to bus 2 (route c)
--  Transfer point (route c) to Lochend (route d)
--  Once we have specified all the necessary routes, we match the stops at each point in the journey. 
 
 
-- Solution 2

SELECT DISTINCT 
   bus1.num, bus1.company, transfer.name, bus2.num, bus2.company
FROM
   route AS bus1 JOIN route AS midA ON  (bus1.num = midA.num AND bus1.company = midA.company)
                 JOIN route AS midD ON (midA.stop = midD.stop)
                 JOIN route AS bus2 ON (midD.num = bus2.num AND midD.company = bus2.company)
                 JOIN stops AS transfer ON (midA.stop = transfer.id)
 WHERE 
   bus1.stop = 53 AND bus2.stop = 147
 ORDER BY 
   bus1.company, bus1.num, midA.stop, bus2.num;
