select location,continent,date,total_cases, new_cases,total_deaths, population 
from PortfolioProject..covidDeaths
--where location = 'World'
order by location, date


--Total infected persons vs Total deaths recorded
--Death percentage if you contract covid in Nigeria
select 
location,date,total_cases, total_deaths, TRY_CAST(total_deaths  as FLOAT)/ TRY_CAST(total_cases as float) * 100 as percent_death
from PortfolioProject..covidDeaths
where location = 'Nigeria'
order by percent_death desc


--How the country's total population fared in percentage vs infected persons
select 
location,date, total_cases,total_deaths,population ,(total_cases/population) * 100 as percent_pop_infected
from PortfolioProject..covidDeaths
--where location = 'Nigeria'
order by percent_pop_infected desc

--Highest infection rate compared to Location
select 
location,MAX(try_cast(total_cases as int)) as max_pop_infected,population ,
MAX(try_cast(total_cases as int)/population) * 100 as percent_pop_infected
from PortfolioProject..covidDeaths
group by location, population
--where location = 'Nigeria'
order by percent_pop_infected desc

--Countries with the Highest death count per population
select 
location,MAX(try_cast(total_deaths as int)) as death_count,
MAX(try_cast(total_deaths as int)/population) * 100 as percent_pop_fatality
from PortfolioProject..covidDeaths
--This totally removes the locations of non-existent continents 
where continent is not NULL 
group by location
--where location = 'Nigeria'
order by death_count desc


--Getting the continents with Highest death count
select 
continent,MAX(try_cast(total_deaths as int)) as death_count,
MAX(try_cast(total_deaths as int)/population) * 100 as percent_pop_fatality
from PortfolioProject..covidDeaths
--This totally removes the locations of non-existent continents 
where continent is not NULL 
group by continent
--where location = 'Nigeria'
order by percent_pop_fatality desc               


-------
select 
sum(new_cases) as total_cases, sum(new_deaths) as total_deaths,
 SUM( new_deaths) /sum(new_cases) * 100 AS death_percent
from PortfolioProject..covidDeaths
--This totally removes the locations of non-existent continents 
where continent is not NULL 
group by date
--where location = 'Nigeria'
order by total_deaths desc     
--------

---join tables to obtain list of people vaccinated 
select * 
from PortfolioProject..covidDeaths

select deaths.continent,deaths.location, deaths.date, deaths.population,vaccine.people_vaccinated
from PortfolioProject..covidDeaths as deaths
 join PortfolioProject..covidVaccination$ as vaccine
on deaths.date = vaccine.date and deaths.location = vaccine.location
where deaths.continent  is not NULL and vaccine.people_vaccinated is not NULL


--Percent of the population getting vaccinated 

WITH vaccine_pop (continent, location,date, population,new_vaccinations, continuous_sum_vaccinations) as
(
select deaths.continent,deaths.location, deaths.date, deaths.population,vaccine.new_vaccinations,
--To partition based on the location each summation of the new_vaccinations is aliased in another column, value remains unchanged when equals NULL
sum(try_cast(vaccine.new_vaccinations as int)) OVER (partition by deaths.location order by deaths.location, deaths.date) as continuous_sum_vaccinations
from PortfolioProject..covidDeaths as deaths
 join PortfolioProject..covidVaccination$ as vaccine
on deaths.date = vaccine.date and deaths.location = vaccine.location
where deaths.continent  is not NULL and vaccine.people_vaccinated is not NULL
--order by location, date
)

select *, (continuous_sum_vaccinations/population)* 100 as percent_vacc_pop
from vaccine_pop

--Using temporary tables
drop table if exists percentage_population_vaccinated
create TABLE percentage_population_vaccinated
(
continent nvarchar(200),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
continuous_sum_vaccinations numeric
)
insert into percentage_population_vaccinated
select deaths.continent,deaths.location, deaths.date, deaths.population,vaccine.new_vaccinations,
--To partition based on the location each summation of the new_vaccinations is aliased in another column, value remains unchanged when equals NULL
sum(try_cast(vaccine.new_vaccinations as int)) OVER (partition by deaths.location order by deaths.location, deaths.date) as continuous_sum_vaccinations
from PortfolioProject..covidDeaths as deaths
 join PortfolioProject..covidVaccination$ as vaccine
on deaths.date = vaccine.date and deaths.location = vaccine.location
where deaths.continent  is not NULL and vaccine.people_vaccinated is not NULL


select *, (continuous_sum_vaccinations/population)* 100 as percent_vacc_pop
from percentage_population_vaccinated
--where continent like '%North%'

--drop table if exists percentage_population_vaccinated
create view percent_pop_vaccinated AS 
select deaths.continent,deaths.location, 
deaths.date, deaths.population,
vaccine.new_vaccinations,
--To partition based on the location each summation of the new_vaccinations is aliased in another column, value remains unchanged when equals NULL
sum(try_cast(vaccine.new_vaccinations as int)) OVER (partition by deaths.location order by deaths.location, deaths.date) as continuous_sum_vaccinations
from PortfolioProject..covidDeaths as deaths
 join PortfolioProject..covidVaccination$ as vaccine
on deaths.date = vaccine.date and deaths.location = vaccine.location
where deaths.continent  is not NULL and vaccine.people_vaccinated is not NULL


select * from percent_pop_vaccinated

---------------------------------------------------------
--Create Views for visualization
---------------------------------------------
with max_vaccinations(continent, max_vacc) as 
(
select deaths.continent,max(try_cast(vaccine.new_vaccinations as int)) as max_vacc
from PortfolioProject..covidDeaths as deaths
 join PortfolioProject..covidVaccination$ as vaccine
on deaths.date = vaccine.date and deaths.location = vaccine.location
where deaths.continent  is not NULL
group by deaths.continent
)
select *
from max_vaccinations
where max_vacc is not NULL


create view highest_vacc_supplied as 
select deaths.continent,max(try_cast(vaccine.new_vaccinations as int)) as max_vacc
from PortfolioProject..covidDeaths as deaths
 join PortfolioProject..covidVaccination$ as vaccine
on deaths.date = vaccine.date and deaths.location = vaccine.location
where deaths.continent  is not NULL
group by deaths.continent

select * from highest_vacc_supplied
---

create view highest_deathCount_continents as 
select 
continent,MAX(try_cast(total_deaths as int)) as death_count,
MAX(try_cast(total_deaths as int)/population) * 100 as percent_pop_fatality
from PortfolioProject..covidDeaths
--This totally removes the locations of non-existent continents 
where continent is not NULL 
group by continent
--where location = 'Nigeria'
--order by percent_pop_fatality desc 

select * from highest_deathCount_continents



