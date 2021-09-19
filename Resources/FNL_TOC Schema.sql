-- creating table for well distance
Create Table well_toc (
	well_id VARCHAR NOT Null,
	TOC DECIMAL,
	PRIMARY KEY (well_id),
	UNIQUE (well_id)
);