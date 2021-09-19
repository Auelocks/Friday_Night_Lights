UPDATE well_data wd
SET    clay_vol = wdc.clay_vol
FROM   well_clay wdc
WHERE  wd.well_id = wdc.well_id
AND    wd.clay_vol IS DISTINCT FROM wdc.clay_vol;