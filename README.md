# COVID-19 Data Analysis Project
>This project focuses on analyzing COVID-19 data using SQL, providing insights into the spread and impact of the pandemic. It leverages SQL queries to extract meaningful information from a COVID-19 database.

## TABLE OF CONTENT


- [Project Overview](#project-Overview)
- [Features](#Features)
- [Getting Started](#Getting-Started)
- [Database Setup](#Database-Setup)
-  [Usage](#Usage)
- [Queries and Examples](#Queries/Examples)
- [Contributing](#Contributing)





## Project Overview 

This project aims to provide valuable insights into COVID-19 data through SQL analysis. Whether you're interested in regional trends, case demographics, or the impact on healthcare systems, this SQL project offers a versatile and interactive approach to exploring pandemic-related data.

## Features 
>* Dynamic Analysis: SQL queries for dynamic analysis of COVID-19 data based on various parameters such as date, location, and demographics.<br><br>
>* Visualization Support: Leverage SQL queries to extract data for visualization tools, creating charts and graphs to enhance data understanding.<br><br>
>* Regional Insights: Explore regional patterns and trends in COVID-19 cases, recoveries, and fatalities.<br><br>
## Getting Started
Follow these steps to get the project up and running on your local machine.<br><br>
### Prerequisites <br>
Ensure you have the following installed:

> ```SQL Server (or any preferred SQL database management system) ```<br>
> ```Your preferred SQL client (e.g., SQL Server Management Studio, Postgres, DBeaver) ```<br>
> I used ssms for data exploration, i will be walking you through the process. <br>
## Database Setup
>* Download the dataset from [Click here](https://ourworldindata.org/covid-deaths) <br><br>
>* Load Dataset in MS Excel then splitted the data into 2 different tables for vaccinations and deaths prevalence.<br><br>
>* create a database name in ssms <br><br>
>* Imported both tables into the database created <br><br>
>* Configured the database connection in your SQL client.<br><br>
## Usage
Explored the power of SQL queries to gain insights into COVID-19 data. Several queries were written to obtain copious information about ; <br>
>* ```Percentage of the poulation of different locations that got vaccinated```<br>
>* ```Highest infection rate compared to location```<br>
>* ```Total infected persons vs Total deaths recorded```<br>
>* ```death percentage if you contract covid in Nigeria``` just to name a few also created ```VIEWS``` for visualization

#### Database Schema
Below is a simplified representation of a COVID-19 database schema:

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
## Queries and Examples
Here are a few examples of SQL queries you can use for analysis:

###### sql
>* Example query 1: Select statement with where clause <br>
```select location,continent,date,total_cases, new_cases,total_deaths, population ```<br>
```from PortfolioProject..covidDeaths```<br>
```where location = 'Nigeria'```<br><br><br>


>* Example query 2: Highest infection rate compared to Location <br>
```select ```<br>
```location,MAX(try_cast(total_cases as int)) as max_pop_infected,population ,```<br>
```MAX(try_cast(total_cases as int)/population) * 100 as percent_pop_infected```<br>
```from PortfolioProject..covidDeaths```<br>
```group by location, population```<br>
```order by percent_pop_infected desc```<br><br><br>


## Contributing
Feel free to contribute to the project by submitting issues or pull requests. Your feedback and improvements are highly valued!
