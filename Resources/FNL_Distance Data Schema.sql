-- creating table for well distance
Create Table well_distance (
	well_id VARCHAR NOT Null,
	Final_dist DECIMAL,
	PRIMARY KEY (well_id),
	UNIQUE (well_id)
);