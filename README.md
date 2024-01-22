## COVID-19 Data Analysis Project
>This project focuses on analyzing COVID-19 data using SQL, providing insights into the spread and impact of the pandemic. It leverages SQL queries to extract meaningful information from a COVID-19 database.

# TABLE OF CONTENT<br>
> Project Overview
---
> Features
---
> Getting Started
---
> Prerequisites
---
> Database Setup
---
> Usage
---
> Database Schema
---
> Queries and Examples
---
> Contributing

# Project Overview <br>
This project aims to provide valuable insights into COVID-19 data through SQL analysis. Whether you're interested in regional trends, case demographics, or the impact on healthcare systems, this SQL project offers a versatile and interactive approach to exploring pandemic-related data.

# Features <br>
> Dynamic Analysis: SQL queries for dynamic analysis of COVID-19 data based on various parameters such as date, location, and demographics.<br>
> Visualization Support: Leverage SQL queries to extract data for visualization tools, creating charts and graphs to enhance data understanding.<br>
> Regional Insights: Explore regional patterns and trends in COVID-19 cases, recoveries, and fatalities.<br><br>
# Getting Started
Follow these steps to get the project up and running on your local machine.<br><br>
## Prerequisites <br>
Ensure you have the following installed:

> ```SQL Server (or any preferred SQL database management system) ```<br>
> ```Your preferred SQL client (e.g., SQL Server Management Studio, Postgres, DBeaver) ```<br>
> I used ssms for data exploration, i will be walking you through the process. <br>
### Database Setup
>* Download the dataset from [Click here](https://ourworldindata.org/covid-deaths) <br><br>
>* Load Dataset in MS Excel then splitted the data into 2 different tables for vaccinations and deaths prevalence.<br><br>
>* create a database name in ssms <br><br>
>* Imported both tables into the database created <br><br>
>* Configured the database connection in your SQL client.<br><br>
### Usage
Explored the power of SQL queries to gain insights into COVID-19 data. Several queries were written to obtain copious information about ; <br>
>* ```Percentage of the poulation of different locations that got vaccinated```<br>
>* ``Highest infection rate compared to location```<br>
>* ```Total infected persons vs Total deaths recorded```
>* ```death percentage if you contract covid in Nigeria``` just to name a few also created ```VIEWS``` for visualization

Database Schema
Below is a simplified representation of the COVID-19 database schema:

sql
Copy code
-- Example Schema
CREATE TABLE covid_data (
    date DATE,
    location VARCHAR(255),
    cases INT,
    recoveries INT,
    fatalities INT
);
Queries and Examples
Here are a few examples of SQL queries you can use for analysis:

sql
Copy code
-- Example query 1: Total cases by region
SELECT location, SUM(cases) as total_cases
FROM covid_data
GROUP BY location;

-- Example query 2: Cases over time
SELECT date, SUM(cases) as daily_cases
FROM covid_data
GROUP BY date
ORDER BY date;
Contributing
Feel free to contribute to the project by submitting issues or pull requests. Your feedback and improvements are highly valued!
