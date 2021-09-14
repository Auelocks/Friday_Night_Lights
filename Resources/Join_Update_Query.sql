UPDATE well_data wd
SET    well_spacing = wdi.final_dist
FROM   well_distance wdi
WHERE  wd.well_id = wdi.well_id
AND    wd.well_spacing IS DISTINCT FROM wdi.final_dist;  -- optional, see below