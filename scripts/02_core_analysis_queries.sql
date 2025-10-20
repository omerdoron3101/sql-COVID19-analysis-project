/* ======================================================================================
   02. Core Analysis Queries
   ======================================================================================
   Purpose:
       This script contains the main analytical queries that measure infection
       and mortality rates across time and geography. These queries calculate
       daily and cumulative metrics to evaluate COVID-19 impact per population.

   Notes:
       - Each block focuses on a distinct business calculation
       - Queries are independent and can be executed separately

   Disclaimer:
       The data used in this project is based on publicly available global
       COVID-19 datasets. While it represents real-world information, it is
       not intended to be interpreted as fully accurate or up to date for
       global analysis or decision-making.

       The dataset may include inconsistencies or missing values.
	   Its purpose here is strictly educational and analytical.
   ====================================================================================== */

-- Calculates the daily death percentage (likelihood of dying from COVID-19 per day)
SELECT
	continent,
	location,
	date,
	total_cases,
	total_deaths,
	CASE WHEN total_cases = 0 THEN 0
	ELSE ROUND((CAST(total_deaths AS FLOAT) / total_cases) * 100, 2)
	END AS death_percengage
FROM dbo.C_Deaths
WHERE continent IS NOT NULL
ORDER BY
	continent,
	location,
	date;

-- Calculates what percentage of the population was infected by date
SELECT
	continent,
	location,
	date,
	population,
	total_cases,
	CASE WHEN total_cases = 0 THEN 0
	ELSE ROUND((CAST(total_cases AS FLOAT) / population) * 100, 2)
	END AS infected_population_percentage
FROM dbo.C_Deaths
WHERE continent IS NOT NULL
ORDER BY
	continent,
	location,
	date;

-- Identifies the locations with the highest infection rates relative to population
SELECT
	continent,
	location,
	population,
	MAX(total_cases) AS highest_infection_count,
	MAX(total_deaths) AS highest_death_count,
	CASE WHEN MAX(total_cases) = 0 THEN 0
	ELSE MAX(ROUND((CAST(total_cases AS FLOAT) / population) * 100, 2)) 
	END AS infected_population_percentage,
	CASE WHEN MAX(total_deaths) = 0 THEN 0
	ELSE MAX(ROUND((CAST(total_deaths AS FLOAT) / population) * 100, 2)) 
	END AS death_population_percentage
FROM dbo.C_Deaths
WHERE continent IS NOT NULL
GROUP BY
	continent,
	location,
	population
ORDER BY infected_population_percentage DESC;

-- Identifies the locations with the highest death rates relative to population
SELECT
	continent,
	location,
	population,
	MAX(total_cases) AS highest_infection_count,
	MAX(total_deaths) AS highest_death_count,
	CASE WHEN MAX(total_cases) = 0 THEN 0
	ELSE MAX(ROUND((CAST(total_cases AS FLOAT) / population) * 100, 2)) 
	END AS infected_population_percentage,
	CASE WHEN MAX(total_deaths) = 0 THEN 0
	ELSE MAX(ROUND((CAST(total_deaths AS FLOAT) / population) * 100, 2)) 
	END AS death_population_percentage
FROM dbo.C_Deaths
WHERE continent IS NOT NULL
GROUP BY
	continent,
	location,
	population
ORDER BY death_population_percentage DESC;
