IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'udacitydemo2_udacitydemo2_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [udacitydemo2_udacitydemo2_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://udacitydemo2@udacitydemo2.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.dim_date
WITH (
    LOCATION     = 'dim_date',
    DATA_SOURCE = [udacitydemo2_udacitydemo2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT 
    date_column AS date,
    DATEPART(WEEKDAY, date_column) AS day_of_week,
    DATEPART(MONTH, date_column) AS month,
    DATEPART(QUARTER, date_column) AS quarter,
    DATEPART(YEAR, date_column) AS year
FROM 
(
    SELECT 
        CAST(start_at AS DATE) AS date_column
    FROM 
        dbo.fact_trip

    UNION

    SELECT 
        CAST(date AS DATE) AS date_column
    FROM 
        dbo.fact_payment
) combined_dates;
GO

SELECT TOP 100 * FROM dbo.dim_date
GO