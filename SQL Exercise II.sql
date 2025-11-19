-- New dataset World
-- How many cities are in the US?
select count(city.name) as 'Amount of Cities', country.name
from city
join country
on city.countrycode = country.code
group by country.name;

-- What country has the highest life expectancy?
select lifeexpectancy, country.name
from country
ORDER BY lifeexpectancy DESC;

-- Can we find all cities with the word 'new'?
select city.name
from city
where city.name like '%new%';

-- What countries have the highest population? Top 10.
select country.population, country.name
from country
ORDER BY country.population DESC
limit 10;

-- What about cities with more than 2 million people?
select city.population, city.name
from city
where city.population >2000000
order by city.Population DESC;

-- Can we find all cities with a prefix of 'Be'?
select city.name
from city
where city.name like 'be%';

-- Cities with population between 500,000 and 1,000,000?
select city.population, city.name
from city
where city.population BETWEEN 500000 and 1000000
order by city.Population DESC;

-- Display Cities Sorted by Name in Ascending Order?
select city.name
from city
order by city.name desc;

-- Can we find the most populated city?
select city.population, city.name
from city
order by city.population desc
limit 1;

-- Can we curate a unique list of all city names sorted alphabetically and how many times the city names appear?
select distinct city.name, count(city.name)
from city
group by city.name
order by city.name;

-- What city has the lowest population?
select city.name, city.population
from city
order by city.population
limit 1;

-- What country has the largest population?
select country.name, country.population
from country
order by country.population DESC
limit 1;

-- How can we find the capital of Spain?
select capital, country.name, city.name as City
from country
join city
on city.countrycode = country.code
where country.name = 'spain' and capital = city.id
order by capital;

-- What cities are in Europe?
select country.name as Country, city.name as City, region
from city
join country
on city.countrycode = country.code
where region like '%europe%';

-- Average population by country?
select country.name, avg(country.population)
from country
group by country.name;

-- Can we compare the capital city populations?
select country.name as CountryName, city.name as CityName, city.population
from city
join country
on city.countrycode = country.code
where capital = city.id;


-- What are the countries with the lowest population density?
select country.name, (country.population/surfacearea)
from country
order by (country.population/surfacearea)
limit 1000 offset 7;

-- Can we find the 31st-40th top City by Population?
select city.name, city.population
from city
order by city.population DESC
limit 10 offset 30;


-- Can we find highest GDP per capita
Select city.name, (country.gnp*1000000/country.population) as gdp 
From country 
Join city 
On country.code = city.countrycode 
Where (country.gnp*1000000/country.population) > (Select avg(gnp*1000000/population) from country) -- this is subquery 
order by gdp DESC;
