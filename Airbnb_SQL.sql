create database AirBnB;
use AirBnB;
show tables;
select * from airbnb;
-- 1 .What is the average price by city and room type?
select City, avg(Price) as Average_Price from airbnb where Country = 'France' group by City order by Average_Price desc limit 5;
select City, round(avg(Price),2) as Average_Price from airbnb where Country = 'Germany' group by City order by Average_Price desc;


-- 2. Which hosts have more than 50 listings?
SELECT `Host ID`, `Host Name`, avg(`Host Listings Count`) AS Listings_Count
FROM airbnb
where Country = 'France'
GROUP BY `Host ID`, `Host Name`
HAVING Listings_Count>50;

SELECT `Host ID`, `Host Name`, avg(`Host Listings Count`) AS Listings_Count
FROM airbnb
where Country = 'Germany'
GROUP BY `Host ID`, `Host Name`
HAVING Listings_Count>5;

-- 3. Which States have the most active listings (based on number of reviews)?
SELECT State, SUM(`Number of Reviews`) AS Reviews_Count FROM airbnb where Country = 'France' GROUP BY State order by Reviews_Count desc limit 5;
SELECT State, SUM(`Number of Reviews`) AS Reviews_Count FROM airbnb where Country = 'Germany' GROUP BY State order by Reviews_Count desc limit 5;

-- 4. Which host have important amenities(wifi, family/kid friendly/pet friendly/laptop workspace)?
SELECT `Host ID`, `Host Name`, `City`, AVG(`Review Scores Rating`) AS Avg_Rating
FROM airbnb
WHERE `WIRELESS INTERNET` = 1
  AND `FAMILY_FRIENDLY` = 1
  AND `PETS_FRIENDLY` = 1
  AND `Laptop Friendly Workspace` = 'Yes'
  and Country='France'
GROUP BY `Host ID`, `Host Name`, `City`
ORDER BY Avg_Rating DESC
LIMIT 5; 

SELECT `Host ID`, `Host Name`, `City`, AVG(`Review Scores Rating`) AS Avg_Rating
FROM airbnb
WHERE `WIRELESS INTERNET` = 1
  AND `FAMILY_FRIENDLY` = 1
  AND `PETS_FRIENDLY` = 1
  AND `Laptop Friendly Workspace` = 'Yes'
  and Country='Germany'
GROUP BY `Host ID`, `Host Name`, `City`
ORDER BY Avg_Rating DESC
LIMIT 5; 


 -- 5. How many listings have review scores above 95 and include “Wireless Internet”?
 select count(*) as Listings_with_High_Reviews_and_Wifi from airbnb  where Country = 'France' and `Review Scores Rating` > 95 and Amenities like '%Wireless Internet%';
 select count(*) as Listings_with_High_Reviews_and_Wifi from airbnb  where Country = 'Germany' and `Review Scores Rating` > 95 and Amenities like '%Wireless Internet%';

-- 6.Find listings with zero cleaning fee but high number of reviews
SELECT * FROM airbnb WHERE `Cleaning Fee` = 0 AND `Number of Reviews` > 100 and Country = 'Germany' ;
SELECT * FROM airbnb WHERE `Cleaning Fee` = 0 AND `Number of Reviews` > 100 and Country = 'France' limit 5 ;

-- 7. Which cancellation policy is most common in high-priced listings?
SELECT `Cancellation Policy`, COUNT(*) as Count FROM airbnb WHERE Country = 'Germany' and Price > 100 GROUP BY `Cancellation Policy` ORDER BY Count DESC ;
SELECT `Cancellation Policy`, COUNT(*) as Count FROM airbnb WHERE Country = 'France' and Price > 500 GROUP BY `Cancellation Policy` ORDER BY Count DESC ;

-- 8.Count listings by host with multiple properties in different cities
 SELECT `Host Name`, COUNT(DISTINCT City) as City_Count, max(`Host Total Listings Count`) as Listings FROM airbnb where Country = 'France'
GROUP BY `Host Name` HAVING City_Count > 1 order by Listings desc limit 5;

SELECT `Host Name`, COUNT(DISTINCT City) as City_Count, max(`Host Total Listings Count`) as Listings FROM airbnb where Country = 'Germany'
GROUP BY `Host Name` HAVING City_Count = 1 order by Listings desc limit 5;

-- 9. Stored Procedure
DELIMITER //

CREATE PROCEDURE GetAveragePriceByCountryRoom(
    IN input_country VARCHAR(100),
    IN input_room_type VARCHAR(100)
)
BEGIN
    SELECT Country, `Room Type`, round(AVG(Price),2) AS Avg_Price_Per_Night
    FROM airbnb
    WHERE Country = input_country
      AND `Room Type` = input_room_type
    GROUP BY Country, `Room Type`;
END //

DELIMITER ;

CALL GetAveragePriceByCountryRoom('Germany', 'Private room');
CALL GetAveragePriceByCountryRoom('France', 'Entire home/apt');



