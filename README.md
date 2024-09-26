Divvy is a bike sharing program in Chicago, Illinois, USA, that allows riders to purchase a pass at a kiosk or use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount of time. The bikes can be returned to the same station or to another. The City of Chicago makes the anonymized bike trip data publicly available for projects like this.

Since the data are anonymous, fake rider and account profiles have been generated along with fake payments to go along with the Divvy Bikeshare data. The image below represents the data model. The tables are: Rider, Account, Payment, Trip, and Station.

![Relational ERD for the Divvy Bikeshare Dataset (with fake data tables)](data_model.jpeg "Relational ERD for the Divvy Bikeshare Dataset (with fake data tables)")

The business outcomes

* Analyze how much time is spent per ride
   * Based on date and time factors such as day of week and time of day
   * Based on which station is the starting and/or ending station
   * Based on age of the rider at time of the ride
   * Based on whether the rider is a member or a casual rider

* Analyze how much money is spent
   * Per month, quarter, year
   * Per member, based on the age of the rider at account start

In the **data warehouse** part, the goal is to develop a data warehouse solution using Azure Synapse Analytics. I will

* Design a star schema based on the business outcomes above
* Import the data into Synapse
* Transform the data into the star schema
* View the reports from Analytics

In the **data lake** part, I build a data lake solution for Divvy bikeshare. The goal is to develop a data lake solution using Azure Databricks and a lake house architecture. I will

* Design a star schema based on the business outcomes above
* Import the data into Azure Databricks using Delta Lake to create a Bronze data store
* Create a gold data store in Delta Lake tables
* Transform the data into the star schema for a Gold data store
