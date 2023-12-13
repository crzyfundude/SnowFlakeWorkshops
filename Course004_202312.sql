use role accountadmin;

select util_db.public.grader(step, (actual = expected), actual, expected, description) as graded_results from
(SELECT 
 'DORA_IS_WORKING' as step
 ,(select 123 ) as actual
 ,123 as expected
 ,'Dora is working!' as description
);

select current_account();


-- PLEASE EDIT THIS TO PUT YOUR EMAIL, FIRST, MIDDLE, & LAST NAMES 
--(remove the angle brackets and put single quotes around each value)
select util_db.public.greeting('lacidian@yahoo.com', 'Douglas', '', 'Lubey');


-----------------------
list @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_CLOTHING 

list @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD

list @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_SNEAKERS


-----

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
 SELECT
 'DLKW01' as step
  ,( select count(*)  
      from ZENAS_ATHLEISURE_DB.INFORMATION_SCHEMA.STAGES 
      where stage_url ilike ('%/clothing%')
      or stage_url ilike ('%/zenas_metadata%')
      or stage_url like ('%/sneakers%')
   ) as actual
, 3 as expected
, 'Stages for Klaus bucket look good' as description
); 


-- workshop 4 : 3
--query all files in  snowflake storage 
select $1 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD as t 


--query a single file - w/o loading it into snowflake first
select $1 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/sweatsuit_sizes.txt as t
---
select $1 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/product_coordination_suggestions.txt; 
---
select $1 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/swt_product_line.txt as t

--- DOUG fix lesson 4 (start) 2023-12-11

where sizes_available <> ''
select $1 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/product_coordination_suggestions.txt; 

create file format zmd_file_format_4
RECORD_DELIMITER = '^'
,FIELD_DELIMITER = '=';  

CREATE VIEW zenas_athleisure_db.products.SWEATBAND_COORDINATION AS 
select replace($1,chr(13)||chr(10)) as PRODUCT_CODE
,replace($2,chr(13)||chr(10)) as HAS_MATCHING_SWEATSUIT 
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/product_coordination_suggestions.txt
(file_format => zmd_file_format_4);

--- DOUG fix lesson 4 (END) 2023-12-11


---
create file format zmd_file_format_1
RECORD_DELIMITER = '^';

select $1
from @uni_klaus_zmd/product_coordination_suggestions.txt
(file_format => zmd_file_format_1);

-----

create file format zmd_file_format_2
FIELD_DELIMITER = '^';  

select $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12
from @uni_klaus_zmd/product_coordination_suggestions.txt
(file_format => zmd_file_format_2);

-----
create file format zmd_file_format_3
FIELD_DELIMITER = '='
,RECORD_DELIMITER = '^';


select $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12
from @uni_klaus_zmd/product_coordination_suggestions.txt
(file_format => zmd_file_format_3);


----------
--query a single file - w/o loading it into snowflake first
select $1 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/sweatsuit_sizes.txt as t

ALTER FILE FORMAT zmd_file_format_1 SET RECORD_DELIMITER = ';';

select $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/sweatsuit_sizes.txt
(file_format => zmd_file_format_1);

----
select $1 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/swt_product_line.txt as t

alter file format zmd_file_format_2
SET RECORD_DELIMITER = ';'
,FIELD_DELIMITER = '|'
,TRIM_SPACE = True;

select $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/swt_product_line.txt
(file_format => zmd_file_format_2);


select replace($1,chr(13)||chr(10)) as sizes_available, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/swt_product_line.txt
(file_format => zmd_file_format_2)
where sizes_available <> ''

-----------
select $1, $2, $3, $4, $5, $6 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/sweatsuit_sizes.txt
DROP VIEW zenas_athleisure_db.products.sweatsuit_sizes


--drop file format zmd_file_format_2
create file format zmd_file_format_2
RECORD_DELIMITER = ';'
,TRIM_SPACE = True;

CREATE view zenas_athleisure_db.products.sweatsuit_sizes as
select replace($1,chr(13)||chr(10)) as sizes_available
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/sweatsuit_sizes.txt
(file_format => zmd_file_format_2)
where sizes_available <> ''

select * from zenas_athleisure_db.products.sweatsuit_sizes

---------

select $1 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/swt_product_line.txt as t

create view zenas_athleisure_db.products.SWEATBAND_PRODUCT_LINE as
select replace($1,chr(13)||chr(10)) as product_code ,$2 as headband_description, $3 as wristband_description 
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/swt_product_line.txt
(file_format => zmd_file_format_2)
where product_code <> ''

select * from zenas_athleisure_db.products.SWEATBAND_PRODUCT_LINE

--------------FIX #5 for 2023-12-11  (start)
--drop view zenas_athleisure_db.products.SWEATBAND_PRODUCT_LINE
select $1 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/swt_product_line.txt as t

create file format zmd_file_format_5
FIELD_DELIMITER = '|'
,RECORD_DELIMITER = ';'
,TRIM_SPACE = True;

create OR REPLACE view zenas_athleisure_db.products.SWEATBAND_PRODUCT_LINE as
select replace($1,chr(13)||chr(10)) as product_code ,$2 as headband_description, $3 as wristband_description 
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/swt_product_line.txt
(file_format => zmd_file_format_5)
where product_code <> ''


select * from zenas_athleisure_db.products.SWEATBAND_PRODUCT_LINE

--------------FIX #5 for 2023-12-11 (END)

select $1 from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/product_coordination_suggestions.txt; 

create file format zmd_file_format_3
FIELD_DELIMITER = '='
,RECORD_DELIMITER = '^';

create view zenas_athleisure_db.products.SWEATBAND_PRODUCT_LINE as
select replace($1,chr(13)||chr(10)) as product_code ,$2 as headband_description, $3 as wristband_description 
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_ZMD/swt_product_line.txt
(file_format => zmd_file_format_2)
where product_code <> ''

SELECT * FROM ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATSUIT_SIZES
--------------FIX #5 for 2023-12-11 (END)

------
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
 SELECT
   'DLKW02' as step
   ,( select sum(tally) from
        (select count(*) as tally
        from ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATBAND_PRODUCT_LINE
        where length(product_code) > 7 
        union
        select count(*) as tally
        from ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATSUIT_SIZES
        where LEFT(sizes_available,2) = char(13)||char(10))     
     ) as actual
   ,0 as expected
   ,'Leave data where it lands.' as description
); 

---COURSE 4  -- LESSON 4
---COURSE 4  -- LESSON 4
---COURSE 4  -- LESSON 4
---COURSE 4  -- LESSON 4
---COURSE 4  -- LESSON 4
list @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_CLOTHING 

select $1
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_CLOTHING/90s_tracksuit.png; 

select metadata$filename, metadata$file_row_number
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_CLOTHING/90s_tracksuit.png;

select metadata$filename, COUNT(metadata$file_row_number)
from @ZENAS_ATHLEISURE_DB.products.UNI_KLAUS_CLOTHING
GROUP BY metadata$filename

----

--Directory Tables
select * from directory(@uni_klaus_clothing);

-- Oh Yeah! We have to turn them on, first
alter stage uni_klaus_clothing 
set directory = (enable = true);

--Now?
select * from directory(@uni_klaus_clothing);

--Oh Yeah! Then we have to refresh the directory table!
alter stage uni_klaus_clothing refresh;

--Now?
select * from directory(@uni_klaus_clothing);

-----
--testing UPPER and REPLACE functions on directory table
select UPPER(RELATIVE_PATH) as uppercase_filename
, REPLACE(uppercase_filename,'/') as no_slash_filename
, REPLACE(no_slash_filename,'_',' ') as no_underscores_filename
, REPLACE(no_underscores_filename,'.PNG') as just_words_filename
from directory(@uni_klaus_clothing);


SELECT REPLACE(
         REPLACE(
           REPLACE(
             UPPER(RELATIVE_PATH),
             '/',''),
           '_',' '),
         '.PNG','') AS formatted_filename
FROM directory(@uni_klaus_clothing);

--------------
--create an internal table for some sweat suit info
--drop table ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATSUITS 
create or replace TABLE ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATSUITS (
	COLOR_OR_STYLE VARCHAR(25),
	DIRECT_URL VARCHAR(200),
	PRICE NUMBER(5,2)
);

--fill the new table with some data
insert into  ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATSUITS 
          (COLOR_OR_STYLE, DIRECT_URL, PRICE)
values
('90s', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/90s_tracksuit.png',500)
,('Burgundy', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/burgundy_sweatsuit.png',65)
,('Charcoal Grey', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/charcoal_grey_sweatsuit.png',65)
,('Forest Green', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/forest_green_sweatsuit.png',65)
,('Navy Blue', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/navy_blue_sweatsuit.png',65)
,('Orange', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/orange_sweatsuit.png',65)
,('Pink', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/pink_sweatsuit.png',65)
,('Purple', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/purple_sweatsuit.png',65)
,('Red', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/red_sweatsuit.png',65)
,('Royal Blue',	'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/royal_blue_sweatsuit.png',65)
,('Yellow', 'https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/yellow_sweatsuit.png',65);


SELECT
	COLOR_OR_STYLE,
	DIRECT_URL,
	PRICE,
    size as image_size,
    last_modified as image_last_modified,
    substring(s.direct_url,54,50)
FROM SWEATSUITS s
    join directory(@uni_klaus_clothing) d 
    on d.relative_path = substring(s.direct_url,54,50)

select * from SWEATSUITS s
select * from directory(@uni_klaus_clothing) d
select * from sweatsuit_sizes;
select distinct sizes_available from sweatsuit_sizes;
delete sweatsuit_sizes where sizes_available=''

-- 3 way join - internal table, directory table, and view based on external data
--drop view zenas_athleisure_db.products.catalog
create view zenas_athleisure_db.products.catalog as
select color_or_style
, direct_url
, price
, size as image_size
, last_modified as image_last_modified
, sizes_available
FROM SWEATSUITS s
    join directory(@uni_klaus_clothing) d 
    on d.relative_path = substring(s.direct_url,54,50)
cross join sweatsuit_sizes;

--

select * from sweatsuits
select * from directory(@uni_klaus_clothing) 
select * from sweatsuit_sizes
select * from zenas_athleisure_db.products.catalog
--/90s_tracksuit.png

select * from zenas_athleisure_db.products.catalog

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
 SELECT
 'DLKW03' as step
 ,( select count(*) from ZENAS_ATHLEISURE_DB.PRODUCTS.CATALOG) as actual
 ,198 as expected
 ,'Cross-joined view exists' as description
); 

--==================================
-- Lesson4+
--==================================

-- Add a table to map the sweat suits to the sweat band sets
create table ZENAS_ATHLEISURE_DB.PRODUCTS.UPSELL_MAPPING
(
SWEATSUIT_COLOR_OR_STYLE varchar(25)
,UPSELL_PRODUCT_CODE varchar(10)
);

--populate the upsell table
insert into ZENAS_ATHLEISURE_DB.PRODUCTS.UPSELL_MAPPING
(
SWEATSUIT_COLOR_OR_STYLE
,UPSELL_PRODUCT_CODE 
)
VALUES
('Charcoal Grey','SWT_GRY')
,('Forest Green','SWT_FGN')
,('Orange','SWT_ORG')
,('Pink', 'SWT_PNK')
,('Red','SWT_RED')
,('Yellow', 'SWT_YLW');


-----
--select * from catalog;
select * from upsell_mapping;
select * from sweatband_coordination
select * from sweatband_product_line
-- Zena needs a single view she can query for her website prototype
--drop view  ZENAS_ATHLEISURE_DB.PRODUCTS.catalog_for_website

create OR REPLACE view ZENAS_ATHLEISURE_DB.PRODUCTS.catalog_for_website as 
select color_or_style
,price
,direct_url
,size_list
,coalesce('BONUS: ' ||  headband_description || ' & ' || wristband_description, 'Consider White, Black or Grey Sweat Accessories')  as upsell_product_desc
from
(   select color_or_style, price, direct_url, image_last_modified,image_size
    ,listagg(sizes_available, ' | ') within group (order by sizes_available) as size_list
    from catalog
    group by color_or_style, price, direct_url, image_last_modified, image_size
) c
left join upsell_mapping u
on u.sweatsuit_color_or_style = c.color_or_style
left join sweatband_coordination sc
on sc.product_code = u.upsell_product_code
left join sweatband_product_line spl
on spl.product_code = sc.product_code
where price < 200 -- high priced items like vintage sweatsuits aren't a good fit for this website
and image_size < 1000000 -- large images need to be processed to a smaller size
and spl.product_code is not null;
;  
----djl 2023-12-11 added additional filter to THE STATEMENT Because code was incorrect .
---- and spl.product_code is not null;

select * from ZENAS_ATHLEISURE_DB.PRODUCTS.catalog_for_website


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT
'DLKW04' as step
 ,( select count(*) 
  from zenas_athleisure_db.products.catalog_for_website 
  where upsell_product_desc like '%NUS:%') as actual
 ,6 as expected
 ,'Relentlessly resourceful' as description
); 



---Course 4 Lesson5
--Make sure everything you create is owned by the SYSADMIN role. 
--Create a database called MELS_SMOOTHIE_CHALLENGE_DB. 
--Drop the PUBLIC schema 
--Add a schema named TRAILS

------------- Lesson 3:3
use role SYSADMIN;

create database MELS_SMOOTHIE_CHALLENGE_DB;
drop schema MELS_SMOOTHIE_CHALLENGE_DB.PUBLIC;
create schema MELS_SMOOTHIE_CHALLENGE_DB.TRAILS;


use role SYSADMIN;
--https://uni-lab-files-more.s3.us-west-2.amazonaws.com/
create stage MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_GEOJSON url = 's3://uni-lab-files-more/dlkw/trails/trails_geojson';
--https://uni-klaus.s3.us-west-2.amazonaws.com/clothing/90s_tracksuit.png
create stage MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_PARQUET url = 's3://uni-lab-files-more/dlkw/trails/trails_parquet';

list @MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_GEOJSON
list @MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_PARQUET

create file format MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.FF_JSON
TYPE = 'JSON';

create file format MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.FF_PARQUET
TYPE = 'PARQUET';

SHOW FILE FORMATS;
--NEXT 2 COMMANDS DO NOT WORK
--SHOW FILE FORMATS IN DATABASE ELS_SMOOTHIE_CHALLENGE_DB SCHEMA TRAILS;
--DESCRIBE FILE FORMAT MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.FF_PARQUET;

SELECT $1 
FROM @MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_GEOJSON
(file_format => MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.FF_JSON)

SELECT $1 
FROM @MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_PARQUET
(file_format =>  MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.FF_PARQUET)


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT
'DLKW05' as step
 ,( select sum(tally)
   from
     (select count(*) as tally
      from mels_smoothie_challenge_db.information_schema.stages 
      union all
      select count(*) as tally
      from mels_smoothie_challenge_db.information_schema.file_formats)) as actual
 ,4 as expected
 ,'Camila\'s Trail Data is Ready to Query' as description
 ); 

-----------------------------------------
-----------------------------------------
---Course 4 Lesson5
-----------------------------------------
-----------------------------------------

SELECT $1 
FROM @MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_PARQUET
(file_format =>  MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.FF_PARQUET)

SELECT 
$1:elevation as elevation,
$1:latitude as latitude,
$1:longitude as longitude,
$1:sequence_1 as sequence_1,
$1:sequence_2 as sequence_2,
$1:trail_name::varchar as trail_name
FROM @MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_PARQUET
(file_format =>  MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.FF_PARQUET)


SELECT 
$1:sequence_1 as point_id,
$1:trail_name::varchar as trail_name,
$1:latitude::number(11,8) as lng,
$1:longitude::number(11,8) as lat
FROM @MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_PARQUET
(file_format =>  MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.FF_PARQUET)
order by point_id

--Nicely formatted trail data
create OR REPLACE view MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.CHERRY_CREEK_TRAIL as 
select 
 $1:sequence_1 as point_id,
 $1:trail_name::varchar as trail_name,
 $1:latitude::number(11,8) as lng, --remember we did a gut check on this data
 $1:longitude::number(11,8) as lat
from @trails_parquet
(file_format => ff_parquet)
order by point_id;

select top 100 * from MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.CHERRY_CREEK_TRAIL order by point_id;


--Using concatenate to prepare the data for plotting on a map
select top 100 
 lng||' '||lat as coord_pair
,'POINT('||coord_pair||')' as trail_point
from MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.CHERRY_CREEK_TRAIL;


--To add a column, we have to replace the entire view
--changes to the original are shown in red
create or replace view cherry_creek_trail as
select 
 $1:sequence_1 as point_id,
 $1:trail_name::varchar as trail_name,
 $1:latitude::number(11,8) as lng,
 $1:longitude::number(11,8) as lat,
 lng||' '||lat as coord_pair
from @trails_parquet
(file_format => ff_parquet)
order by point_id;

select 
'LINESTRING('||
listagg(coord_pair, ',') 
within group (order by point_id)
||')' as my_linestring
from cherry_creek_trail
where point_id <= 10
group by trail_name;

----
-- https://clydedacruz.github.io/openstreetmap-wkt-playground/
select 
'LINESTRING('||
listagg(coord_pair, ',') 
within group (order by point_id)
||')' as my_linestring
from cherry_creek_trail
--where point_id <= 10
group by trail_name;


create or replace view MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.DENVER_AREA_TRAILS as
select
$1:features[0]:properties:Name::string as feature_name
,$1:features[0]:geometry:coordinates::string as feature_coordinates
,$1:features[0]:geometry::string as geometry
,$1:features[0]:properties::string as feature_properties
,$1:crs:properties:name::string as specs
,$1 as whole_object
from @trails_geojson (file_format => ff_json);


select * from MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.DENVER_AREA_TRAILS



select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT
'DLKW06' as step
 ,( select count(*) as tally
      from mels_smoothie_challenge_db.information_schema.views 
      where table_name in ('CHERRY_CREEK_TRAIL','DENVER_AREA_TRAILS')) as actual
 ,2 as expected
 ,'Mel\'s views on the geospatial data from Camila' as description
 ); 


 -----------------------------------------
-----------------------------------------
---Course 4 Lesson7
-----------------------------------------
-----------------------------------------

--Remember this code? 
select 
'LINESTRING('||
listagg(coord_pair, ',') 
within group (order by point_id)
||')' as my_linestring
,TO_GEOGRAPHY(my_linestring) as length_of_trail --this line is new! but it won't work!  st_length(my_linestring) as length_of_trail
from cherry_creek_trail
group by trail_name;


select get_ddl('view', 'DENVER_AREA_TRAILS');

create or replace view DENVER_AREA_TRAILS(
	FEATURE_NAME,
	FEATURE_COORDINATES,
	GEOMETRY,
	FEATURE_PROPERTIES,
	SPECS,
	WHOLE_OBJECT,
    TRAIL_LENGTH
) as
select
$1:features[0]:properties:Name::string as feature_name
,$1:features[0]:geometry:coordinates::string as feature_coordinates
,$1:features[0]:geometry::string as geometry
,$1:features[0]:properties::string as feature_properties
,$1:crs:properties:name::string as specs
,$1 as whole_object
,ST_LENGTH(TO_GEOGRAPHY($1:features[0]:geometry)) as trail_length
from @trails_geojson (file_format => ff_json);


select * from DENVER_AREA_TRAILS

--Create a view that will have similar columns to DENVER_AREA_TRAILS 
--Even though this data started out as Parquet, and we're joining it with geoJSON data
--So let's make it look like geoJSON instead.
create view DENVER_AREA_TRAILS_2 as
select 
trail_name as feature_name
,'{"coordinates":['||listagg('['||lng||','||lat||']',',')||'],"type":"LineString"}' as geometry
,st_length(to_geography(geometry)) as trail_length
from cherry_creek_trail
group by trail_name;


--Create a view that will have similar columns to DENVER_AREA_TRAILS 
select feature_name, geometry, trail_length
from DENVER_AREA_TRAILS
union all
select feature_name, geometry, trail_length
from DENVER_AREA_TRAILS_2;


--Add more GeoSpatial Calculations to get more GeoSpecial Information! 
create or replace view TRAILS_AND_BOUNDARIES AS
select feature_name
, to_geography(geometry) as my_linestring
, st_xmin(my_linestring) as min_eastwest
, st_xmax(my_linestring) as max_eastwest
, st_ymin(my_linestring) as min_northsouth
, st_ymax(my_linestring) as max_northsouth
, trail_length
from DENVER_AREA_TRAILS
union all
select feature_name
, to_geography(geometry) as my_linestring
, st_xmin(my_linestring) as min_eastwest
, st_xmax(my_linestring) as max_eastwest
, st_ymin(my_linestring) as min_northsouth
, st_ymax(my_linestring) as max_northsouth
, trail_length
from DENVER_AREA_TRAILS_2;

SELECT * FROM TRAILS_AND_BOUNDARIES


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
 SELECT
  'DLKW07' as step
   ,( select round(max(max_northsouth))
      from MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.TRAILS_AND_BOUNDARIES)
      as actual
 ,40 as expected
 ,'Trails Northern Extent' as description
 ); 

 -----------------------------------------
-----------------------------------------
---Course 4 Lesson8
-----------------------------------------
-----------------------------------------
 --SHOW TABLES IN DATABASE OPENSTREETMAP_DENVER
 --SHOW VIEWS IN DATABASE OPENSTREETMAP_DENVER  
SHOW functions IN DATABASE MELS_SMOOTHIE_CHALLENGE_DB
SHOW functions IN schema MELS_SMOOTHIE_CHALLENGE_DB.LOCATIONS where isbuiltin<>'Y'

 -- Melanie's Location into a 2 Variables (mc for melanies cafe)
set mc_lat='-104.97300245114094';
set mc_lng='39.76471253574085';

--Confluence Park into a Variable (loc for location)
set loc_lat='-105.00840763333615'; 
set loc_lng='39.754141917497826';

--Test your variables to see if they work with the Makepoint function
select st_makepoint($mc_lat,$mc_lng) as melanies_cafe_point;
select st_makepoint($loc_lat,$loc_lng) as confluent_park_point;

--use the variables to calculate the distance from 
--Melanie's Cafe to Confluent Park
select st_distance(
        st_makepoint($mc_lat,$mc_lng)
        ,st_makepoint($loc_lat,$loc_lng)
        ) as mc_to_cp;
     

use role SYSADMIN;

create schema MELS_SMOOTHIE_CHALLENGE_DB.LOCATIONS;

create or replace FUNCTION MELS_SMOOTHIE_CHALLENGE_DB.LOCATIONS.distance_to_mc(loc_lat number(38,32), loc_lng number(38,32))
  RETURNS FLOAT
  AS
  $$
   st_distance(
        st_makepoint('-104.97300245114094','39.76471253574085')
        ,st_makepoint(loc_lat,loc_lng)
        )
  $$
  ;

--Tivoli Center into the variables 
set tc_lat='-105.00532059763648'; 
set tc_lng='39.74548137398218';

select distance_to_mc($tc_lat,$tc_lng);


create or replace view COMPETITION as 
select * 
--from SONRA_DENVER_CO_USA_FREE.DENVER.V_OSM_DEN_AMENITY_SUSTENANCE
--
from OPENSTREETMAP_DENVER.DENVER.V_OSM_DEN_AMENITY_SUSTENANCE
where 
    ((amenity in ('fast_food','cafe','restaurant','juice_bar'))
    and 
    (name ilike '%jamba%' or name ilike '%juice%'
     or name ilike '%superfruit%'))
 or 
    (cuisine like '%smoothie%' or cuisine like '%juice%');


select * from COMPETITION

CREATE OR REPLACE FUNCTION distance_to_mc(lat_and_lng GEOGRAPHY)
  RETURNS FLOAT
  AS
  $$
   st_distance(
        st_makepoint('-104.97300245114094','39.76471253574085')
        ,lat_and_lng
        )
  $$
  ;


  SELECT
 name
 ,cuisine
 ,distance_to_mc(coordinates) AS distance_from_melanies
 ,*
FROM  competition
ORDER by distance_from_melanies;




create or replace view DENVER_BIKE_SHOPS as 
select * 
--from SONRA_DENVER_CO_USA_FREE.DENVER.V_OSM_DEN_AMENITY_SUSTENANCE
--
from OPENSTREETMAP_DENVER.DENVER.V_OSM_DEN_SHOP
where shop = 'bicycle' -- ('bike_shops')

select * from DENVER_BIKE_SHOPS

SELECT
 name
 ,distance_to_mc(coordinates) AS distance_from_melanies
 ,*
FROM DENVER_BIKE_SHOPS
ORDER by distance_from_melanies;

create or replace view DENVER_BIKE_SHOPS as 
select * 
,distance_to_mc(coordinates) AS distance_to_melanies
from OPENSTREETMAP_DENVER.DENVER.V_OSM_DEN_SHOP
where shop = 'bicycle' -- ('bike_shops')


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
  SELECT
  'DLKW08' as step
  ,( select truncate(distance_to_melanies)
      from mels_smoothie_challenge_db.locations.denver_bike_shops
      where name like '%Mojo%') as actual
  ,14084 as expected
  ,'Bike Shop View Distance Calc works' as description
 ); 




 -----------------------------------------
-----------------------------------------
---Course 4 Lesson9
-----------------------------------------
-----------------------------------------
select * from MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.cherry_creek_trail

alter view MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.cherry_creek_trail
rename to MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.v_cherry_creek_trail


create or replace external table T_CHERRY_CREEK_TRAIL(
	my_filename varchar(50) as (metadata$filename::varchar(50))
) 
location= @trails_parquet
auto_refresh = true
file_format = (type = parquet);


select get_ddl('view','mels_smoothie_challenge_db.trails.v_cherry_creek_trail');


create or replace external table T_CHERRY_CREEK_TRAIL(
POINT_ID number as ($1:sequence_1::number),
TRAIL_NAME varchar (50) as ($1:trail_name::varchar),
LNG number(11,8) as ($1:Latitude::number(11,8)),
LAT number(11,8) as ($1:Longitude::number(11,8)),
COORD_PAIR varchar (50) as (lng::varchar||' '||lat::varchar)
)
location = @trails_parquet   
auto_refresh = true
file_format = ff_parquet;

create or replace external table mels_smoothie_challenge_db.trails.T_CHERRY_CREEK_TRAIL(
	POINT_ID number as ($1:sequence_1::number),
	TRAIL_NAME varchar(50) as  ($1:trail_name::varchar),
	LNG number(11,8) as ($1:latitude::number(11,8)),
	LAT number(11,8) as ($1:longitude::number(11,8)),
	COORD_PAIR varchar(50) as (lng::varchar||' '||lat::varchar)
) 
location= @mels_smoothie_challenge_db.trails.trails_parquet
auto_refresh = true
file_format = mels_smoothie_challenge_db.trails.ff_parquet;

select * from MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.T_CHERRY_CREEK_TRAIL


CREATE OR REPLACE SECURE MATERIALIZED VIEW MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.SMV_CHERRY_CREEK_TRAIL
AS SELECT * FROM MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.T_CHERRY_CREEK_TRAIL;

select count(*) from MELS_SMOOTHIE_CHALLENGE_DB.TRAILS.SMV_CHERRY_CREEK_TRAIL


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
  SELECT
  'DLKW09' as step
  ,( select row_count
     from mels_smoothie_challenge_db.information_schema.tables
     where table_schema = 'TRAILS'
    and table_name = 'SMV_CHERRY_CREEK_TRAIL')   
   as actual
  ,3526 as expected
  ,'Secure Materialized View Created' as description
 ); 
