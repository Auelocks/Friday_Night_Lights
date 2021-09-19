UPDATE well_data wd
SET    TOC = wdt.TOC
FROM   well_toc wdt
WHERE  wd.well_id = wdt.well_id
AND    wd.TOC IS DISTINCT FROM wdt.TOC; 