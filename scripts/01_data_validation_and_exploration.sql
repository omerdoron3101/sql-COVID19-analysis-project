/* ======================================================================================
   01. Data Validation And Exploration
   ======================================================================================
   Purpose:
       This script performs initial data validation and exploration.
       It identifies data gaps, validates continent and location coverage,
       and provides a preliminary understanding of COVID-19 case and death
       distributions across regions and countries.

   Notes:
       - These queries are diagnostic and exploratory in nature
       - They should not be converted into permanent views or tables

   Disclaimer:
       The data used in this project is based on publicly available global
       COVID-19 datasets. While it represents real-world information, it is
       not intended to be interpreted as fully accurate or up to date for
       global analysis or decision-making.

       The dataset may include inconsistencies or missing values.
	   Its purpose here is strictly educational and analytical.
   ====================================================================================== */

-- Validation and data completeness checks for missing continent values
-- Used to verify the proportion of global data without assigned continents
SELECT
	location,
	MAX(total_deaths) AS total_death_count
FROM dbo.C_Deaths
WHERE continent IS NULL
GROUP BY location;

-- Compare data completeness for locations with valid continents
SELECT
	location,
	MAX(total_deaths) AS total_death_count
FROM dbo.C_Deaths
WHERE continent IS NOT NULL
GROUP BY location;

-- Aggregate by continent to identify which regions have the highest mortality
SELECT
	continent,
	MAX(total_deaths) AS total_death_count
FROM dbo.C_Deaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC;

-- Display raw case and death trends by location and date for exploratory analysis
SELECT
	continent,
	location,
	date,
	total_cases,
	new_cases,
	total_deaths,
	new_deaths,
	population
FROM dbo.C_Deaths
WHERE continent IS NOT NULL
ORDER BY
	continent,
	location,
	date;
