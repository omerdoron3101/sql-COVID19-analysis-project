# 🧪 SQL COVID19 Analysis Project

This project provides a comprehensive SQL-based analysis of global COVID-19 cases and vaccination data. It aims to prepare, clean, and transform raw datasets to enable insights into daily cases, deaths, fatality rates, and vaccination coverage by country and globally.

**⚠️ Note:** The data used in this project is sourced from public datasets. It may contain inconsistencies and should not be used to draw real-world conclusions without further validation. The project is intended for learning, demonstration, and analytical purposes.

---

## 🌐 Data Sources
- **C_Deaths.csv**: Daily COVID-19 cases, deaths, hospitalizations, testing, vaccinations, and demographic information per country.
- **C_Vaccinations.csv**: Daily and cumulative vaccination data, testing, and demographic information per country.

---

## 🏗️ Project Structure
1. **Tables**
   - `C_Deaths`: Base table for COVID-19 death and case data.
   - `C_Vaccinations`: Base table for vaccination and testing data.

2. **Views**
   - `daily_global_cases_and_deaths`: Calculates global daily totals and relative percentages of new cases and deaths.
   - `percent_population_vaccinated`: Calculates cumulative vaccinations and expresses them as a percentage of the population per country.

---

## 📊 Key Calculations
- **Daily Percentage of Total Cases/Deaths**: Shows the contribution of each day to total cases/deaths.
- **Daily Case Fatality Rate**: Measures the proportion of infected individuals who died on a given day.
- **Cumulative Vaccinations**: Rolling sum of daily vaccinations per country.
- **Percent of Population Vaccinated**: Share of the population vaccinated up to a specific date.

---

## 📈 Tableau Dashboard

This SQL analysis was further visualized and transformed into an interactive **Tableau Dashboard** to provide a clear, visual understanding of the data trends and insights.

👉 **View the live dashboard here:**  
🔗 [COVID-19 Dashboard — Tableau Public](https://public.tableau.com/app/profile/omer.doron/viz/COVID-19Dashboard_17609599687590/Dashboard1)

### 🖼️ Preview
![Dashboard Preview](https://public.tableau.com/static/images/CO/COVID-19Dashboard_17609599687590/Dashboard1/1.png)

*(If the preview above doesn’t load, you can view it directly on Tableau Public using the link above.)*

---

## ⚠️ Disclaimer
The datasets are publicly available and may contain errors or missing values. The results generated are for analytical and educational purposes and should not be interpreted as official COVID-19 statistics.

---

## 🛡️ License
This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.

---

## 🌟 About Me
👋 Hi! I'm **Omer Doron**  
I’m a student of Information Systems specializing in **Digital Innovation**.  
I’m passionate about transforming raw information into meaningful insights.  

I created this project as part of my learning journey in **data warehousing and analytics**, and as a showcase of my **technical and analytical skills**.

🔗 [Connect with me on LinkedIn](https://www.linkedin.com/in/omer-doron-a070732b1/)
