-- creating tables for well data
Create Table well_data (
	well_id VARCHAR NOT Null,
	Lease_name VARCHAR(50) NOT NULL,
	operator_company VARCHAR(50),
	county VARCHAR(50),
	Landing_zone VARCHAR(50),
	Date_completed DATE,
	Lateral_len DECIMAL,
	Total_fluid DECIMAL,
	Total_proppant DECIMAL,
	Well_spacing DECIMAL,
	fluid DECIMAL,
	prop DECIMAL,
	avg_ppg DECIMAL,
	oil_eur DECIMAL,
	gas_eur DECIMAL,
	isopach DECIMAL,
	porosity DECIMAL,
	sw DECIMAL,
	TVD DECIMAL,
	FVF DECIMAL,
	PRIMARY KEY (well_id),
	UNIQUE (well_id)

);

SELECT * FROM well_data;