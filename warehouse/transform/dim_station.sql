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

CREATE EXTERNAL TABLE dbo.dim_station
WITH (
    LOCATION     = 'dim_station',
    DATA_SOURCE = [udacitydemo2_udacitydemo2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT
	[station_id],
	[name],
	[latitude],
	[longitude]
FROM [dbo].[staging_station];
GO

SELECT TOP 100 * FROM dbo.dim_station
GO