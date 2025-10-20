/* ======================================================================================
   DDL Script: Create And Load  COVID-19 Tables
   ======================================================================================
   Purpose:
       This script creates the base tables for the COVID-19 project, loads data
       from CSV files, and ensures proper date formatting.

   ⚠️ Warning:
	   Running this script will DROP and RECREATE all existing  COVID-19 tables.
	   Any previously loaded data in these tables will be permanently deleted.

   Disclaimer:
       The data used in this project is based on publicly available global
       COVID-19 datasets. While it represents real-world information, it is
       not intended to be interpreted as fully accurate or up to date for
       global analysis or decision-making.

       The dataset may include inconsistencies or missing values due to
       reporting differences across countries. Its purpose here is strictly
       educational and analytical — to simulate a business-oriented data
       project using diverse real-world information sources.
   ====================================================================================== */

/* ======================================================================================
   Table: C_Deaths
   --------------------------------------------------------------------------------------
   Base table for COVID-19 death and case data. Includes daily counts,
   smoothed metrics, hospitalizations, tests, vaccinations, and demographic info.
   ====================================================================================== */

IF OBJECT_ID ('C_Deaths', 'U') IS NOT NULL
    DROP TABLE C_Deaths;
GO

CREATE TABLE C_Deaths (
    iso_code NVARCHAR(50),
    continent NVARCHAR(50),
    location NVARCHAR(50),
    date NVARCHAR(50),
    total_cases INT,
    new_cases INT,
    new_cases_smoothed DECIMAL,
    total_deaths INT,
    new_deaths INT,
    new_deaths_smoothed DECIMAL,
    total_cases_per_million DECIMAL,
    new_cases_per_million DECIMAL,
    new_cases_smoothed_per_million DECIMAL,
    total_deaths_per_million DECIMAL,
    new_deaths_per_million DECIMAL,
    new_deaths_smoothed_per_million DECIMAL,
    reproduction_rate DECIMAL,
    icu_patients DECIMAL,
    icu_patients_per_million DECIMAL(18,2),
    hosp_patients DECIMAL(18,2),
    hosp_patients_per_million DECIMAL(18,2),
    weekly_icu_admissions DECIMAL(18,2),
    weekly_icu_admissions_per_million DECIMAL(18,2),
    weekly_hosp_admissions DECIMAL(18,2),
    weekly_hosp_admissions_per_million DECIMAL(18,2),
    new_tests DECIMAL(18,2),
    total_tests DECIMAL(18,2),
    total_tests_per_thousand DECIMAL(18,2),
    new_tests_per_thousand DECIMAL(18,2),
    new_tests_smoothed DECIMAL(18,2),
    new_tests_smoothed_per_thousand DECIMAL(18,2),
    positive_rate DECIMAL(5,4),
    tests_per_case DECIMAL(18,2),
    tests_units NVARCHAR(50),
    total_vaccinations DECIMAL(18,2),
    people_vaccinated DECIMAL(18,2),
    people_fully_vaccinated DECIMAL(18,2),
    new_vaccinations DECIMAL(18,2),
    new_vaccinations_smoothed DECIMAL(18,2),
    total_vaccinations_per_hundred DECIMAL(18,2),
    people_vaccinated_per_hundred DECIMAL(18,2),
    people_fully_vaccinated_per_hundred DECIMAL(18,2),
    new_vaccinations_smoothed_per_million DECIMAL(18,2),
    stringency_index DECIMAL(5,2),
    population BIGINT,
    population_density DECIMAL(10,2),
    median_age DECIMAL(5,2),
    aged_65_older DECIMAL(5,2),
    aged_70_older DECIMAL(5,2),
    gdp_per_capita DECIMAL(18,2),
    extreme_poverty DECIMAL(5,2),
    cardiovasc_death_rate DECIMAL(5,2),
    diabetes_prevalence DECIMAL(5,2),
    female_smokers DECIMAL(5,2),
    male_smokers DECIMAL(5,2),
    handwashing_facilities DECIMAL(5,2),
    hospital_beds_per_thousand DECIMAL(5,2),
    life_expectancy DECIMAL(5,2),
    human_development_index DECIMAL(5,3)
);
GO

/* ======================================================================================
   Table: C_Vaccinations
   --------------------------------------------------------------------------------------
   Base table for COVID-19 vaccination data, including daily and cumulative
   vaccinations, testing, and demographic info.
   ====================================================================================== */

IF OBJECT_ID ('C_Vaccinations', 'U') IS NOT NULL
    DROP TABLE C_Vaccinations;
GO

CREATE TABLE C_Vaccinations (
    iso_code NVARCHAR(10),
    continent NVARCHAR(50),
    location NVARCHAR(100),
    date NVARCHAR(50),
    new_tests DECIMAL(18,2),
    total_tests DECIMAL(18,2),
    total_tests_per_thousand DECIMAL(18,2),
    new_tests_per_thousand DECIMAL(18,2),
    new_tests_smoothed DECIMAL(18,2),
    new_tests_smoothed_per_thousand DECIMAL(18,2),
    positive_rate DECIMAL(5,4),
    tests_per_case DECIMAL(18,2),
    tests_units NVARCHAR(50),
    total_vaccinations DECIMAL(18,2),
    people_vaccinated DECIMAL(18,2),
    people_fully_vaccinated DECIMAL(18,2),
    new_vaccinations DECIMAL(18,2),
    new_vaccinations_smoothed DECIMAL(18,2),
    total_vaccinations_per_hundred DECIMAL(18,2),
    people_vaccinated_per_hundred DECIMAL(18,2),
    people_fully_vaccinated_per_hundred DECIMAL(18,2),
    new_vaccinations_smoothed_per_million DECIMAL(18,2),
    stringency_index DECIMAL(5,2),
    population_density DECIMAL(10,2),
    median_age DECIMAL(5,2),
    aged_65_older DECIMAL(5,2),
    aged_70_older DECIMAL(5,2),
    gdp_per_capita DECIMAL(18,2),
    extreme_poverty DECIMAL(5,2),
    cardiovasc_death_rate DECIMAL(5,2),
    diabetes_prevalence DECIMAL(5,2),
    female_smokers DECIMAL(5,2),
    male_smokers DECIMAL(5,2),
    handwashing_facilities DECIMAL(5,2),
    hospital_beds_per_thousand DECIMAL(5,2),
    life_expectancy DECIMAL(5,2),
    human_development_index DECIMAL(5,3)
);
GO

/* ======================================================================================
   Load Data from CSV Files
   --------------------------------------------------------------------------------------
   Bulk insert raw CSV data into the tables for further processing.
   FIRSTROW = 2 is used to skip headers.
   ====================================================================================== */

BULK INSERT C_Deaths
FROM 'C:\Users\User\Desktop\Project SQL Data Warehouse\C_Deaths.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

BULK INSERT C_Vaccinations
FROM 'C:\Users\User\Desktop\Project SQL Data Warehouse\C_Vaccinations.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO 

/* ======================================================================================
   Convert 'date' Columns to Proper DATE Type
   --------------------------------------------------------------------------------------
   Ensures that the date columns are in the correct SQL DATE format for
   time-based calculations and analytics.
   ====================================================================================== */
ALTER TABLE C_Deaths
ADD date_new DATE;
GO

UPDATE C_Deaths
SET date_new = CONVERT(DATE, date, 103);  -- 103 format = dd/mm/yyyy
GO

ALTER TABLE C_Deaths
DROP COLUMN date;
GO

EXEC sp_rename 'C_Deaths.date_new', 'date', 'COLUMN';
GO

ALTER TABLE C_Vaccinations
ADD date_new DATE;
GO

UPDATE C_Vaccinations
SET date_new = CONVERT(DATE, date, 103);  -- 103 format = dd/mm/yyyy
GO

ALTER TABLE C_Vaccinations
DROP COLUMN date;
GO

EXEC sp_rename 'C_Vaccinations.date_new', 'date', 'COLUMN';
GO
