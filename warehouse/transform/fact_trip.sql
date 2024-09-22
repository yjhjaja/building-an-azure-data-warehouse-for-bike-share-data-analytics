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

CREATE EXTERNAL TABLE dbo.fact_trip WITH (
    LOCATION     = 'fact_trip',
    DATA_SOURCE = [udacitydemo2_udacitydemo2_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
        st.trip_id, 
        st.rideable_type, 
        st.start_at, 
        st.ended_at, 
        st.start_station_id, 
        st.end_station_id, 
        st.rider_id,
        DATEDIFF(MINUTE, st.start_at, st.ended_at) AS trip_duration,
        DateDIFF(YEAR, sr.birthday, st.start_at) AS rider_age,
        CASE
            WHEN DATEPART(HOUR, st.start_at) BETWEEN 6 AND 11 THEN 'Morning'
            WHEN DATEPART(HOUR, st.start_at) BETWEEN 12 AND 17 THEN 'Afternoon'
            WHEN DATEPART(HOUR, st.start_at) BETWEEN 18 AND 21 THEN 'Evening'
            ELSE 'Night'
        END AS time_of_day
    FROM 
        dbo.staging_trip AS st
        JOIN dbo.staging_rider AS sr
        ON st.rider_id = sr.rider_id
);
GO

SELECT TOP 100 * FROM dbo.fact_trip
GO