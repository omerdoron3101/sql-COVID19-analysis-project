/* ======================================================================================
   03. Views Daily And Vaccination Analysis
   ======================================================================================
   Purpose:
       This script creates analytical SQL views that calculate daily and
       cumulative COVID-19 metrics.
	   These include:
		   - Global daily infection and death trends
		   - Vaccination progress as a percentage of each country's population

   Notes:
       - Views are designed for reporting and trend analysis
       - Each view is recreated safely (DROP + CREATE pattern)

   Disclaimer:
       The data used in this project is based on publicly available global
       COVID-19 datasets. While it represents real-world information, it is
       not intended to be interpreted as fully accurate or up to date for
       global analysis or decision-making.

       The dataset may include inconsistencies or missing values.
	   Its purpose here is strictly educational and analytical.
   ====================================================================================== */


/* ======================================================================================
   View: Daily Global Cases And Deaths
   --------------------------------------------------------------------------------------
   Description:
	   Calculates global daily totals and relative percentages of new cases
	   and deaths across the entire dataset.

   Business Logic:
	   - daily_percentage_of_total_cases: Shows the daily share of global infections.
	   - daily_percentage_of_total_deaths: Shows the daily share of global deaths.
	   - daily_case_fatality_rate: Measures the fatality rate among infected individuals per day.
   ====================================================================================== */
IF OBJECT_ID('daily_global_cases_and_deaths', 'V') IS NOT NULL
	DROP VIEW daily_global_cases_and_deaths;
GO

CREATE VIEW daily_global_cases_and_deaths AS
	SELECT
		date,
		SUM(new_cases) AS daily_new_cases,
		SUM(new_deaths) AS daily_new_deaths,
		SUM(SUM(new_cases)) OVER() AS global_total_cases_over_time,
		ROUND(CAST(SUM(new_cases) AS FLOAT) / SUM(SUM(new_cases)) OVER() * 100, 2) AS daily_percentage_of_total_cases,
		ROUND(CAST(SUM(new_deaths) AS FLOAT) / SUM(SUM(new_cases)) OVER() * 100, 2) AS daily_percentage_of_total_deaths,
		ROUND((CAST(SUM(new_deaths) AS FLOAT) / SUM(new_cases)) * 100, 2) AS daily_case_fatality_rate
	FROM dbo.C_Deaths
	WHERE continent IS NOT NULL
	GROUP BY date;
GO

/* ======================================================================================
   View: Percent Population Vaccinated
   --------------------------------------------------------------------------------------
   Description:
	   Calculates the cumulative number of vaccinated individuals and expresses
	   it as a percentage of the total population by date and location.

   Business Logic:
	   - cumulative_vaccinations: Rolling sum of daily vaccinations per country.
	   - percent_of_population_vaccinated: Share of the population vaccinated to date.
   ====================================================================================== */

IF OBJECT_ID('percent_population_vaccinated', 'V') IS NOT NULL
	DROP VIEW percent_population_vaccinated;
GO

CREATE VIEW percent_population_vaccinated AS
	WITH pop_vs_vac AS (
		SELECT 
			dea.continent,
			dea.location,
			dea.population,
			dea.date,
			vac.new_vaccinations,
			SUM(vac.new_vaccinations) OVER(PARTITION BY dea.location ORDER BY dea.continent, dea.location, dea.date) AS cumulative_vaccinations
		FROM dbo.C_Deaths dea 
		INNER JOIN dbo.C_Vaccinations vac
		ON	       dea.location = vac.location
		AND        dea.date = vac.date
		WHERE dea.continent IS NOT NULL
	)
	SELECT 
		continent,
		location,
		population,
		date,
		new_vaccinations,
		ROUND((cumulative_vaccinations / population) * 100, 2) AS percent_of_population_vaccinated
	FROM pop_vs_vac;
GO
