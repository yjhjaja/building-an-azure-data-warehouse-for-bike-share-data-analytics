In this project, I build a data lake solution for Divvy bikeshare.

Divvy is a bike sharing program in Chicago, Illinois, USA that allows riders to purchase a pass at a kiosk or use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount of time. The bikes can be returned to the same station or to another. The City of Chicago makes the anonymized bike trip data publicly available for projects like this.

Since the data are anonymous, fake rider and account profiles have been generated along with fake payment data to go along with the data from Divvy. The dataset looks like this:

![alt text](data_structure_raw.jpeg "Title")

This image represents the data model for the dataset based on the Divvy Bikeshare data. The tables include: Rider, Account, Payment, Trip, and Station.
Relational ERD for the Divvy Bikeshare Dataset (with fake data tables)

The goal of this project is to develop a data lake solution using Azure Databricks using a lake house architecture. You will:

Design a star schema based on the business outcomes listed below;
Import the data into Azure Databricks using Delta Lake to create a Bronze data store;
Create a gold data store in Delta Lake tables;
Transform the data into the star schema for a Gold data store;
The business outcomes you are designing for are as follows:
Analyze how much time is spent per ride
Based on date and time factors such as day of week and time of day
Based on which station is the starting and / or ending station
Based on age of the rider at time of the ride
Based on whether the rider is a member or a casual rider
Analyze how much money is spent
Per month, quarter, year
Per member, based on the age of the rider at account start









The files in folder **lake** instruct one how to implement a data lake and ELT in Azure.

The files in folder **warehouse** instruct one how to implement a data warehouse and ELT in Azure.
