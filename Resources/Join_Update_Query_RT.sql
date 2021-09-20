UPDATE well_data wd
SET    rock_type = wdr.rock_type
FROM   well_rt wdr
WHERE  wd.well_id = wdr.well_id
AND    wd.rock_type IS DISTINCT FROM wdr.rock_type;