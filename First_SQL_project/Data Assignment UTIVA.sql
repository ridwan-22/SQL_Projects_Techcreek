-- SECTION A      PROFIT ANALYSIS

-- 1) Profit worth of the breweries for both anglophone and francophone territories

select sum("PROFIT") AS "TOTAL_PROFIT"
FROM "brewery_data";

-- 2) Compare the total profit between anglo and franco

select distinct "COUNTRIES"
FROM "brewery_data";

select "TERRITORY", SUM("PROFIT") AS "TERRITORIAL_PROFIT"
FROM
(select *,
case when "COUNTRIES" IN('Nigeria', 'Ghana') then 'Anglophone'
else 'Francophone' end as "TERRITORY"
FROM "brewery_data") as "tab1"
GROUP BY 1;

-- 3) Country that generated the highest profit in 2019

SELECT "COUNTRIES","YEARS", MAX("PROFIT") AS "HIGHEST_PROFIT"
FROM "brewery_data"
WHERE "YEARS" = 2019
group by "COUNTRIES","YEARS"
ORDER BY 2
limit 1;

-- 4)  find the year with the highest profit
 
 SELECT "YEARS", MAX("PROFIT") AS "HIGHEST_PROFIT"
 FROM "brewery_data"
 group by 1
 order by 2 desc
limit 1;

-- 5)   month in the three years was the least profit generated

select "MONTHS", "YEARS", MIN("PROFIT") AS "LEAST_PROFITABLE"
FROM "brewery_data"
group by "MONTHS", "YEARS"
order by 3 asc
limit 1;


-- 6)   minimum profit in the month of December 2018

select "MONTHS", "YEARS", MIN("PROFIT")
FROM "brewery_data"
where "MONTHS" = 'December' and "YEARS" = 2018
GROUP BY 1,2
ORDER BY 3;


-- 7) Compare the profit in percentage for each of the month in 2019 

 SELECT "MONTHS", "YEARS", ROUND((SUM("PROFIT") / SUM("COST")) * 100, 2) AS "PROFIT_PERC"
 FROM "brewery_data"
 where "YEARS" = 2019
 GROUP BY "MONTHS", "YEARS"
 ORDER BY 3;
 
 
-- 8) Particular brand that generated the highest profit in Senegal

SELECT "BRANDS", "COUNTRIES", MAX("PROFIT") as "LEADING_BRAND_PROFIT"
FROM "brewery_data"
where "COUNTRIES" = 'Senegal'
group by "BRANDS", "COUNTRIES"
order by 3 DESC;



--     SECTION B, BRAND ANALYSIS


-- 1) Top three brands consumed in the francophone countries in the last two years 

select "BRANDS", "YEARS", "TOP_BRAND_QTY"
from
(select "COUNTRIES", "BRANDS", "YEARS", SUM("QUANTITY") AS "TOP_BRAND_QTY"
FROM "brewery_data"
where "COUNTRIES" IN ('Senegal', 'Benin', 'Togo')
GROUP BY "COUNTRIES", "BRANDS", "YEARS"
order by 4 desc) as "tab2"
where "YEARS" BETWEEN 2017 AND 2018
GROUP BY "BRANDS", "YEARS", 3
ORDER BY 3 DESC
LIMIT 3;


-- 2) Top two choice of consumer brands in Ghana 

SELECT "BRANDS", SUM ("QUANTITY") AS "TOP_CHOICE"
FROM "brewery_data"
where "COUNTRIES" = 'Ghana'
group by "BRANDS"
ORDER BY 2 DESC
LIMIT 2;

-- 3) Details of beers consumed in the past three years in Nigeria

select *
from
(select *
 from "brewery_data"
 where "BRANDS" NOT IN('beta malt','grand malt')) as t2
 where "COUNTRIES" = 'Nigeria';
 
 
-- 4) Favorites malt brand in Anglophone region between 2018 and 2019
 
 SELECT "BRANDS", SUM("MAX") AS "FAVOURITE_BRAND"
 FROM
 (SELECT "BRANDS", "YEARS", SUM("QUANTITY") AS "MAX"
 FROM
(select *
from "Anglophone"
where "YEARS" BETWEEN 2018 AND 2019) AS "TABLE"
GROUP BY 1, 2
ORDER BY 3) AS "NEWW"
WHERE "BRANDS" IN ('beta malt', 'grand malt') AND "YEARS" BETWEEN 2018 AND 2019
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;


-- 5) Brands sold the highest in 2019 in Nigeria

SELECT "BRANDS",SUM("QUANTITY") AS "TOTAL_QTY", SUM("UNIT_PRICE") AS "SALES"
FROM "brewery_data"
where "COUNTRIES" = 'Nigeria' and "YEARS" = 2019
GROUP BY "BRANDS"
ORDER BY 3 DESC;


-- 6) Favorites brand in South_South region in Nigeria 

SELECT "BRANDS", "REGION", SUM("QUANTITY") AS "FAV_BRAND"
FROM "brewery_data"
where "COUNTRIES" = 'Nigeria' AND "REGION" = 'southsouth'
GROUP BY "BRANDS", "REGION"
ORDER BY 3 DESC;


-- 7) Bear consumption in Nigeria 

select "BRANDS", SUM("QUANTITY") AS "CONSUMPTION"
FROM "brewery_data"
where "COUNTRIES" = 'Nigeria' and "BRANDS" NOT IN ('grand malt', 'beta malt')
GROUP BY 1
ORDER BY 2 DESC;


-- 8) Level of consumption of Budweiser in the regions in Nigeria 

SELECT *
FROM
(select "BRANDS", "REGION", SUM("QUANTITY") AS "CONSUMPTION_level"
FROM "brewery_data"
where "COUNTRIES" = 'Nigeria' and "BRANDS" NOT IN ('grand malt', 'beta malt')
GROUP BY 1,2
ORDER BY 2 DESC) AS "NEWWWW"
WHERE "BRANDS" = 'budweiser';


-- 9) Level of consumption of Budweiser in the regions in Nigeria in 2019 

select *
from
(SELECT *
FROM
(select "BRANDS", "YEARS", "REGION", SUM("QUANTITY") AS "CONSUMPTION_level"
FROM "brewery_data"
where "COUNTRIES" = 'Nigeria' and "BRANDS" NOT IN ('grand malt', 'beta malt')
GROUP BY 1,2,3
ORDER BY 4 DESC) AS "NEWWWW"
WHERE "BRANDS" = 'budweiser') as "latest"
where "YEARS" = 2019;



-- SECTION C          COUNTRIES ANALYSIS

-- 1) Country with the highest consumption of beer

SELECT DISTINCT "COUNTRIES", COUNT ("BRANDS") AS "BRAND_COUNT", Max("HIGH") AS "HIGHEST_CONSUMPTION"
from
(SELECT "COUNTRIES", "BRANDS", SUM("QUANTITY") AS "HIGH"
FROM "brewery_data"
WHERE "BRANDS" NOT IN ('grand malt', 'beta malt')
group by "COUNTRIES", "BRANDS"
order by 3 DESC) AS "NEW_LATEST"
GROUP BY 1
ORDER BY 3 DESC
LIMIT 1;


-- 2)  Highest sales personnel of Budweiser in Senegal

SELECT "SALES_REP", "BRANDS", "COUNTRIES", SUM("QUANTITY") AS "SOLD"
FROM "brewery_data"
where "BRANDS" = 'budweiser' and "COUNTRIES" = 'Senegal'
group by 1, 2, 3
order by 4 desc
LIMIT 1;


-- 3) Country with the highest profit of the fourth quarter in 2019

select "COUNTRIES", "QUARTERLY", "YEARS", SUM("PROFIT") AS "HIGHEST_PROFIT"
FROM
(SELECT *, 
CASE WHEN "MONTHS" IN ('January', 'February', 'March') then 'Q1'
WHEN "MONTHS" IN ('April', 'May', 'June') then 'Q2'
WHEN "MONTHS" IN ('July', 'August', 'September') then 'Q3'
else 'Q4' END AS "QUARTERLY"
FROM "brewery_data") AS "Q_T"
WHERE "YEARS" = 2019 AND "QUARTERLY" = 'Q4'
GROUP BY 1, 2, 3
ORDER BY 4 DESC
LIMIT 1;
















 
 
 
 
 
 
 
 
 
 
 
 
 
 
 













































