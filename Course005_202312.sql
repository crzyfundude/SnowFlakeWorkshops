--does not work  (not sure why)
--SHOW USERS LIKE 'KISHOREK';
--alter user KISHOREK set default_role = 'SYSADMIN';
--alter user KISHOREK set default_warehouse = 'COMPUTE_WH';
--alter user KISHOREK set default_namespace = 'UTIL_DB.PUBLIC';


use role accountadmin;

select util_db.public.grader(step, (actual = expected), actual, expected, description) as graded_results from
(SELECT 
 'DORA_IS_WORKING' as step
 ,(select 123 ) as actual
 ,123 as expected
 ,'Dora is working!' as description
); 

select current_account();
--TYB20273

-- PLEASE EDIT THIS TO PUT YOUR EMAIL, FIRST, MIDDLE, & LAST NAMES 
--(remove the angle brackets and put single quotes around each value)
select util_db.public.greeting('lacidian@yahoo.com', 'Douglas', '', 'Lubey');

------------- Lesson 3:3
use role SYSADMIN;

create database AGS_GAME_AUDIENCE;
drop schema AGS_GAME_AUDIENCE.PUBLIC;
create schema AGS_GAME_AUDIENCE.RAW;



use role SYSADMIN;
--create an internal table for some sweat suit info
--drop table ZENAS_ATHLEISURE_DB.PRODUCTS.SWEATSUITS 
create or replace TABLE AGS_GAME_AUDIENCE.RAW.GAME_LOGS (
	RAW_LOG VARIANT
);

select * from AGS_GAME_AUDIENCE.RAW.GAME_LOGS

--https://uni-lab-files-more.s3.us-west-2.amazonaws.com/
create or replace stage AGS_GAME_AUDIENCE.RAW.UNI_KISHORE url = 's3://uni-kishore';

list @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE/kickoff;

--s3://uni-kishore/kickoff/DNGW_Sample_from_Agnies_Game.json
create or replace file format AGS_GAME_AUDIENCE.RAW.FF_JSON_LOGS
TYPE = 'JSON'
,strip_outer_array = true;


select $1 
from @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE/kickoff
(file_format => ff_json_logs);


copy into AGS_GAME_AUDIENCE.RAW.GAME_LOGS
from @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE/kickoff
file_format = (format_name=ff_json_logs)

//Add a CAST command to the fields returned  and path statemwents
create OR REPLACE view AGS_GAME_AUDIENCE.RAW.LOGS as
select 
RAW_LOG:agent::text as AGENT
,RAW_LOG:datetime_iso8601::TIMESTAMP_NTZ as DATETIME_ISO8601
,RAW_LOG:user_event::text as USER_EVENT
,RAW_LOG:user_login::text as USER_LOGIN 
,RAW_LOG
from AGS_GAME_AUDIENCE.RAW.GAME_LOGS


{
  "agent": "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/534.18 (KHTML, like Gecko) Chrome/11.0.660.0 Safari/534.18",
  "datetime_iso8601": "2022-10-13T01:24:53Z",
  "user_event": "login",
  "user_login": "atamlett0"
}



select * from AGS_GAME_AUDIENCE.RAW.LOGS


-- DO NOT EDIT THIS CODE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
 SELECT
 'DNGW01' as step
  ,(
      select count(*)  
      from ags_game_audience.raw.logs
      where is_timestamp_ntz(to_variant(datetime_iso8601))= TRUE 
   ) as actual
, 250 as expected
, 'Project DB and Log File Set Up Correctly' as description
); 


-------------------------------------------------
-------------------------------------------------
-- COURSE #5 :Lesson 3
-------------------------------------------------
-------------------------------------------------
--what time zone is your account(and/or session) currently set to? Is it -0700?
select current_timestamp();
--2023-12-12 18:42:41.004 +0000

--worksheets are sometimes called sessions -- we'll be changing the worksheet time zone
alter session set timezone = 'UTC';
select current_timestamp();
--2023-12-12 18:42:56.992 +0000

--how did the time differ after changing the time zone for the worksheet?
alter session set timezone = 'Africa/Nairobi';
select current_timestamp();
--2023-12-12 21:43:35.064 +0300

alter session set timezone = 'Pacific/Funafuti';
select current_timestamp();
--2023-12-13 06:43:52.691 +1200

alter session set timezone = 'Asia/Shanghai';
select current_timestamp();
2023-12-13 02:44:06.977 +0800

--show the account parameter called timezone
show parameters like 'timezone';

-----------------------------------------------------------------------

https://uni-kishore.s3.us-west-2.amazonaws.com/kickoff/
https://uni-kishore.s3.us-west-2.amazonaws.com/updated_feed/
https://uni-kishore.s3.us-west-2.amazonaws.com/updated_feed/DNGW_updated_feed_0_0_0.json

  "datetime_iso8601": "2022-10-13T01:24:53Z",
  ip_address:
  "user_event": "login",
  "user_login": "atamlett0"

copy into AGS_GAME_AUDIENCE.RAW.GAME_LOGS
from @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE/updated_feed
file_format = (format_name=ff_json_logs)

select * from AGS_GAME_AUDIENCE.RAW.GAME_LOGS

select 
$1:agent::text, 
$1:ip_address::text
from AGS_GAME_AUDIENCE.RAW.GAME_LOGS


select * from AGS_GAME_AUDIENCE.RAW.LOGS

select * from AGS_GAME_AUDIENCE.RAW.LOGS where agent is null

--looking for empty AGENT column
select * 
from ags_game_audience.raw.LOGS
where agent is null;

--looking for non-empty IP_ADDRESS column
select 
RAW_LOG:ip_address::text as IP_ADDRESS
,*
from ags_game_audience.raw.LOGS
where RAW_LOG:ip_address::text is not null;


---- do it myself
drop view AGS_GAME_AUDIENCE.RAW.LOGS
//Add a CAST command to the fields returned  and path statemwents
create OR REPLACE view AGS_GAME_AUDIENCE.RAW.LOGS as
select 
--RAW_LOG:agent::text as AGENT
RAW_LOG:ip_address::text as IP_ADDRESS 
,RAW_LOG:datetime_iso8601::TIMESTAMP_NTZ as DATETIME_ISO8601
,RAW_LOG:user_event::text as USER_EVENT
,RAW_LOG:user_login::text as USER_LOGIN 
,RAW_LOG
from AGS_GAME_AUDIENCE.RAW.GAME_LOGS
where IP_ADDRESS is not null 

select * from AGS_GAME_AUDIENCE.RAW.LOGS  -- view
select * from AGS_GAME_AUDIENCE.RAW.GAME_LOGS   --table


select * from AGS_GAME_AUDIENCE.RAW.LOGS where UPPER(USER_LOGIN) like '%PR%'
select * from AGS_GAME_AUDIENCE.RAW.GAME_LOGS where UPPER(raw_log) like '%PR%'

select * from AGS_GAME_AUDIENCE.RAW.LOGS where UPPER(USER_LOGIN) like '%PRAJINA%'
select * from AGS_GAME_AUDIENCE.RAW.GAME_LOGS where UPPER(raw_log) like '%PRAJINA%'


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT
   'DNGW02' as step
   ,( select sum(tally) from(
        select (count(*) * -1) as tally
        from ags_game_audience.raw.logs 
        union all
        select count(*) as tally
        from ags_game_audience.raw.game_logs)     
     ) as actual
   ,250 as expected
   ,'View is filtered' as description
); 

--------------------------------
--------------------------------
-- COURSE 5  - LESSON 4
--------------------------------
--------------------------------

select parse_ip('100.41.16.160','inet');
select parse_ip('107.217.231.17','inet'):family;
select parse_ip('107.217.231.17','inet'):host;

create schema AGS_GAME_AUDIENCE.ENHANCED;


ALTER DATABASE IPINFO_IP_GEOLOCATION_SAMPLE RENAME TO IPINFO_GEOLOC;

GRANT IMPORTED PRIVILEGES ON DATABASE IPINFO_GEOLOC TO ROLE SYSADMIN;

select top 200 * from IPINFO_GEOLOC.DEMO.LOCATION

select IPINFO_GEOLOC.public.TO_INT('1.2')


---

--Look up Kishore and Prajina's Time Zone in the IPInfo share using his headset's IP Address with the PARSE_IP function.
select start_ip, end_ip, start_ip_int, end_ip_int, city, region, country, timezone
from IPINFO_GEOLOC.demo.location
where parse_ip('100.41.16.160', 'inet'):ipv4 --Kishore's Headset's IP Address
BETWEEN start_ip_int AND end_ip_int;



--Join the log and location tables to add time zone to each row using the PARSE_IP function.
select logs.*
       , loc.city
       , loc.region
       , loc.country
       , loc.timezone
from AGS_GAME_AUDIENCE.RAW.LOGS logs
join IPINFO_GEOLOC.demo.location loc
where parse_ip(logs.ip_address, 'inet'):ipv4 
BETWEEN start_ip_int AND end_ip_int;


-- Your role should be SYSADMIN
-- Your database menu should be set to AGS_GAME_AUDIENCE
-- The schema should be set to RAW

--a Look Up table to convert from hour number to "time of day name"
create table ags_game_audience.raw.time_of_day_lu
(  hour number
   ,tod_name varchar(25)
);

--insert statement to add all 24 rows to the table
insert into ags_game_audience.raw.time_of_day_lu
values
(6,'Early morning'),
(7,'Early morning'),
(8,'Early morning'),
(9,'Mid-morning'),
(10,'Mid-morning'),
(11,'Late morning'),
(12,'Late morning'),
(13,'Early afternoon'),
(14,'Early afternoon'),
(15,'Mid-afternoon'),
(16,'Mid-afternoon'),
(17,'Late afternoon'),
(18,'Late afternoon'),
(19,'Early evening'),
(20,'Early evening'),
(21,'Late evening'),
(22,'Late evening'),
(23,'Late evening'),
(0,'Late at night'),
(1,'Late at night'),
(2,'Late at night'),
(3,'Toward morning'),
(4,'Toward morning'),
(5,'Toward morning');



--Check your table to see if you loaded it properly
select tod_name, listagg(hour,',') 
from ags_game_audience.raw.time_of_day_lu
group by tod_name;
--TO_JOIN_KEY
--TO_INT 

--Use two functions supplied by IPShare to help with an efficient IP Lookup Process!
SELECT logs.ip_address
, logs.user_login as GAMER_NAME
, logs.user_event as GAME_EVENT_NAME
, logs.datetime_iso8601 as GAME_EVENT_UTC
, city
, region
, country
, timezone as GAMER_LTZ_NAME
, convert_timezone('UTC',timezone,logs.datetime_iso8601) as GAME_EVENT_TZ
, DayName(game_event_tz) as DOW_NAME
, TOD_NAME 
from AGS_GAME_AUDIENCE.RAW.LOGS logs
JOIN IPINFO_GEOLOC.demo.location loc 
    ON IPINFO_GEOLOC.public.TO_JOIN_KEY(logs.ip_address) = loc.join_key
    AND IPINFO_GEOLOC.public.TO_INT(logs.ip_address) 
    BETWEEN start_ip_int AND end_ip_int
JOIN ags_game_audience.raw.time_of_day_lu hrs
    ON hrs.hour = Hour(game_event_tz)



--Wrap any Select in a CTAS statement
create OR REPLACE table ags_game_audience.enhanced.logs_enhanced as(
    --Use two functions supplied by IPShare to help with an efficient IP Lookup Process!
    SELECT logs.ip_address
    , logs.user_login as GAMER_NAME
    , logs.user_event as GAME_EVENT_NAME
    , logs.datetime_iso8601 as GAME_EVENT_UTC
    , city
    , region
    , country
    , timezone as GAMER_LTZ_NAME
    , convert_timezone('UTC',timezone,logs.datetime_iso8601) as GAME_EVENT_TZ
    , DayName(game_event_tz) as DOW_NAME
    , TOD_NAME 
    from AGS_GAME_AUDIENCE.RAW.LOGS logs
    JOIN IPINFO_GEOLOC.demo.location loc 
        ON IPINFO_GEOLOC.public.TO_JOIN_KEY(logs.ip_address) = loc.join_key
        AND IPINFO_GEOLOC.public.TO_INT(logs.ip_address) 
        BETWEEN start_ip_int AND end_ip_int
    JOIN ags_game_audience.raw.time_of_day_lu hrs
        ON hrs.hour = Hour(game_event_tz)
);

select * from ags_game_audience.enhanced.logs_enhanced


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
  SELECT
   'DNGW03' as step
   ,( select count(*) 
      from ags_game_audience.enhanced.logs_enhanced
      where dow_name = 'Sat'
      and tod_name = 'Early evening'   
      and gamer_name like '%prajina'
     ) as actual
   ,2 as expected
   ,'Playing the game on a Saturday evening' as description
); 


----------------------------------------------
----------------------------------------------
-- LESSON 5
----------------------------------------------
----------------------------------------------

--You have to run this grant or you won't be able to test your tasks while in SYSADMIN role
--this is true even if SYSADMIN owns the task!!
grant execute task on account to role SYSADMIN;

--Now you should be able to run the task, even if your role is set to SYSADMIN
execute task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED;

--the SHOW command might come in handy to look at the task 
show tasks in account;


------------------------
--you can also look at any task more in depth using DESCRIBE  - DDL Data Definition 
describe task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED;

------------------------
SELECT GET_DDL('TASK', 'AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED');

create or replace task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED
	warehouse=COMPUTE_WH
	schedule='5 minute'
	as 
INSERT INTO AGS_GAME_AUDIENCE.ENHANCED.LOGS_ENHANCED
SELECT logs.ip_address
, logs.user_login as GAMER_NAME
, logs.user_event as GAME_EVENT_NAME
, logs.datetime_iso8601 as GAME_EVENT_UTC
, city
, region
, country
, timezone as GAMER_LTZ_NAME
, convert_timezone('UTC',timezone,logs.datetime_iso8601) as GAME_EVENT_TZ
, DayName(game_event_tz) as DOW_NAME
, TOD_NAME 
from AGS_GAME_AUDIENCE.RAW.LOGS logs
JOIN IPINFO_GEOLOC.demo.location loc 
    ON IPINFO_GEOLOC.public.TO_JOIN_KEY(logs.ip_address) = loc.join_key
    AND IPINFO_GEOLOC.public.TO_INT(logs.ip_address) 
    BETWEEN start_ip_int AND end_ip_int
JOIN ags_game_audience.raw.time_of_day_lu hrs
    ON hrs.hour = Hour(game_event_tz);


--make a note of how many rows you have in the table
select count(*)
from AGS_GAME_AUDIENCE.ENHANCED.LOGS_ENHANCED;

--Run the task to load more rows
execute task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED;

--check to see how many rows were added
select count(*)
from AGS_GAME_AUDIENCE.ENHANCED.LOGS_ENHANCED;


---------------

truncate table AGS_GAME_AUDIENCE.ENHANCED.LOGS_ENHANCED;

--------------------

--clone the table to save this version as a backup
--since it holds the records from the UPDATED FEED file, we'll name it _UF
create table ags_game_audience.enhanced.LOGS_ENHANCED_UF 
clone ags_game_audience.enhanced.LOGS_ENHANCED;

--select * from AGS_GAME_AUDIENCE.ENHANCED.LOGS_ENHANCED
--select * from ags_game_audience.RAW.LOGS

MERGE INTO ags_game_audience.enhanced.LOGS_ENHANCED e
USING ags_game_audience.RAW.LOGS r
ON r.user_login = e.GAMER_NAME
    and r.datetime_iso8601 = e.game_event_utc
    and r.user_event = e.game_event_name
WHEN MATCHED THEN
UPDATE SET IP_ADDRESS = 'Hey I updated matching rows!';


--let's truncate so we can start the load over again
-- remember we have that cloned back up so it's fine
truncate table AGS_GAME_AUDIENCE.ENHANCED.LOGS_ENHANCED;
-----

create or replace task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED
	warehouse=COMPUTE_WH
	schedule='5 minute'
	as 
MERGE INTO ags_game_audience.enhanced.LOGS_ENHANCED e
USING (
SELECT logs.ip_address
, logs.user_login as GAMER_NAME
, logs.user_event as GAME_EVENT_NAME
, logs.datetime_iso8601 as GAME_EVENT_UTC
, city
, region
, country
, timezone as GAMER_LTZ_NAME
, convert_timezone('UTC',timezone,logs.datetime_iso8601) as GAME_EVENT_TZ
, DayName(game_event_tz) as DOW_NAME
, TOD_NAME 
from AGS_GAME_AUDIENCE.RAW.LOGS logs
JOIN IPINFO_GEOLOC.demo.location loc 
    ON IPINFO_GEOLOC.public.TO_JOIN_KEY(logs.ip_address) = loc.join_key
    AND IPINFO_GEOLOC.public.TO_INT(logs.ip_address) 
    BETWEEN start_ip_int AND end_ip_int
JOIN ags_game_audience.raw.time_of_day_lu hrs
    ON hrs.hour = Hour(game_event_tz)
) r
ON r.GAMER_NAME = e.GAMER_NAME
    and r.GAME_EVENT_UTC = e.game_event_utc
    and r.GAME_EVENT_NAME = e.game_event_name
WHEN NOT MATCHED THEN
INSERT (IP_ADDRESS, GAMER_NAME, GAME_EVENT_NAME, GAME_EVENT_UTC, CITY, REGION, COUNTRY, GAMER_LTZ_NAME, GAME_EVENT_TZ, DOW_NAME, TOD_NAME)
VALUES (IP_ADDRESS, GAMER_NAME, GAME_EVENT_NAME, GAME_EVENT_UTC, CITY, REGION, COUNTRY, GAMER_LTZ_NAME, GAME_EVENT_TZ, DOW_NAME, TOD_NAME);


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT
'DNGW04' as step
 ,( select count(*)/iff (count(*) = 0, 1, count(*))
  from table(ags_game_audience.information_schema.task_history
              (task_name=>'LOAD_LOGS_ENHANCED'))) as actual
 ,1 as expected
 ,'Task exists and has been run at least once' as description 
 ); 



----------------------------------------------
----------------------------------------------
-- LESSON 6
----------------------------------------------
----------------------------------------------

--drop stage AGS_GAME_AUDIENCE.RAW.UNI_KISHORE_PIPELINE
--drop table AGS_GAME_AUDIENCE.RAW.PIPELINE_LOGS
 --https://uni-lab-files-more.s3.us-west-2.amazonaws.com/
create or replace stage AGS_GAME_AUDIENCE.RAW.UNI_KISHORE_PIPELINE url = 's3://uni-kishore-pipeline';

list @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE_PIPELINE


create or replace table AGS_GAME_AUDIENCE.RAW.PIPELINE_LOGS (RAW_LOG VARIANT)
--select * from AGS_GAME_AUDIENCE.RAW.GAME_LOGS


--logs_1_10_0_0_0.json
--logs_11_20_0_0_0.json
copy into AGS_GAME_AUDIENCE.RAW.PIPELINE_LOGS
from @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE_PIPELINE
file_format = (format_name=AGS_GAME_AUDIENCE.RAW.ff_json_logs)

select * from AGS_GAME_AUDIENCE.RAW.PIPELINE_LOGS


create or replace view AGS_GAME_AUDIENCE.RAW.PL_LOGS as (
select 
 RAW_LOG:datetime_iso8601::TIMESTAMP_NTZ as DATETIME_ISO8601
,RAW_LOG:ip_address::text as IP_ADDRESS 
,RAW_LOG:user_event::text as USER_EVENT 
,RAW_LOG:user_login::text as USER_LOGIN 
from AGS_GAME_AUDIENCE.RAW.PIPELINE_LOGS
)

select * from AGS_GAME_AUDIENCE.RAW.PL_LOGS


create or replace task AGS_GAME_AUDIENCE.RAW.GET_NEW_FILES
	warehouse=COMPUTE_WH
	schedule='5 minute'
	as 
copy into AGS_GAME_AUDIENCE.RAW.PIPELINE_LOGS
from @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE_PIPELINE
file_format = (format_name=AGS_GAME_AUDIENCE.RAW.ff_json_logs)


--Run the task to load more rows
execute task AGS_GAME_AUDIENCE.RAW.GET_NEW_FILES;

--check to see how many rows were added
select count(*)
from AGS_GAME_AUDIENCE.RAW.PIPELINE_LOGS;


ALTER TASK AGS_GAME_AUDIENCE.RAW.GET_NEW_FILES RESUME;
ALTER TASK AGS_GAME_AUDIENCE.RAW.GET_NEW_FILES suspend;


--Turning on a task is done with a RESUME command
alter task AGS_GAME_AUDIENCE.RAW.GET_NEW_FILES resume;
alter task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED resume;


--Turning on a task is done with a RESUME command
alter task AGS_GAME_AUDIENCE.RAW.GET_NEW_FILES suspend;
alter task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED suspend;


--Step 1 - how many files in the bucket?
list @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE_PIPELINE;

--Step 2 - number of rows in raw table (should be file count x 10)
select count(*) from AGS_GAME_AUDIENCE.RAW.PIPELINE_LOGS;

--Step 3 - number of rows in raw table (should be file count x 10)
select count(*) from AGS_GAME_AUDIENCE.RAW.PL_LOGS;

--Step 4 - number of rows in enhanced table (should be file count x 10 but fewer rows is okay)
select count(*) from AGS_GAME_AUDIENCE.ENHANCED.LOGS_ENHANCED;

----------------------
use role accountadmin;
grant EXECUTE MANAGED TASK on account to SYSADMIN;

--switch back to sysadmin
use role sysadmin;


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT
'DNGW05' as step
 ,(
   select max(tally) from (
       select CASE WHEN SCHEDULED_FROM = 'SCHEDULE' 
                         and STATE= 'SUCCEEDED' 
              THEN 1 ELSE 0 END as tally 
   from table(ags_game_audience.information_schema.task_history (task_name=>'GET_NEW_FILES')))
  ) as actual
 ,1 as expected
 ,'Task succeeds from schedule' as description
 ); 



 --------------------------------------------
 --------------------------------------------
 --  COURSE 5 lesson7
 --------------------------------------------
 --------------------------------------------

create or replace TABLE AGS_GAME_AUDIENCE.RAW.ED_PIPELINE_LOGS as 
  SELECT 
    METADATA$FILENAME as log_file_name --new metadata column
  , METADATA$FILE_ROW_NUMBER as log_file_row_id --new metadata column
  , current_timestamp(0) as load_ltz --new local time of load
  , get($1,'datetime_iso8601')::timestamp_ntz as DATETIME_ISO8601
  , get($1,'user_event')::text as USER_EVENT
  , get($1,'user_login')::text as USER_LOGIN
  , get($1,'ip_address')::text as IP_ADDRESS    
  FROM @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE_PIPELINE
  (file_format => 'ff_json_logs');



select * from AGS_GAME_AUDIENCE.RAW.ED_PIPELINE_LOGS

---------------------

--truncate the table rows that were input during the CTAS
truncate table ED_PIPELINE_LOGS;

--reload the table using your COPY INTO
COPY INTO AGS_GAME_AUDIENCE.RAW.ED_PIPELINE_LOGS
FROM (
    SELECT 
    METADATA$FILENAME as log_file_name 
  , METADATA$FILE_ROW_NUMBER as log_file_row_id 
  , current_timestamp(0) as load_ltz 
  , get($1,'datetime_iso8601')::timestamp_ntz as DATETIME_ISO8601
  , get($1,'user_event')::text as USER_EVENT
  , get($1,'user_login')::text as USER_LOGIN
  , get($1,'ip_address')::text as IP_ADDRESS    
  FROM @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE_PIPELINE
)
file_format = (format_name = ff_json_logs);


---------------------------------------
---------------------------------------
--  LESSON 8 
---------------------------------------
---------------------------------------

CREATE OR REPLACE PIPE GET_NEW_FILES
auto_ingest=true
aws_sns_topic='arn:aws:sns:us-west-2:321463406630:dngw_topic'
AS 
COPY INTO ED_PIPELINE_LOGS
FROM (
    SELECT 
    METADATA$FILENAME as log_file_name 
  , METADATA$FILE_ROW_NUMBER as log_file_row_id 
  , current_timestamp(0) as load_ltz 
  , get($1,'datetime_iso8601')::timestamp_ntz as DATETIME_ISO8601
  , get($1,'user_event')::text as USER_EVENT
  , get($1,'user_login')::text as USER_LOGIN
  , get($1,'ip_address')::text as IP_ADDRESS    
  FROM @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE_PIPELINE
)
file_format = (format_name = ff_json_logs);

alter pipe GET_NEW_FILES set pipe_execution_paused = true;

-------
use role accountadmin;
grant EXECUTE MANAGED TASK on account to SYSADMIN;

--switch back to sysadmin
use role sysadmin;

create or replace task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED
	warehouse=COMPUTE_WH
	schedule='5 minute'
	as 
COPY INTO ED_PIPELINE_LOGS
FROM (
    SELECT 
    METADATA$FILENAME as log_file_name 
  , METADATA$FILE_ROW_NUMBER as log_file_row_id 
  , current_timestamp(0) as load_ltz 
  , get($1,'datetime_iso8601')::timestamp_ntz as DATETIME_ISO8601
  , get($1,'user_event')::text as USER_EVENT
  , get($1,'user_login')::text as USER_LOGIN
  , get($1,'ip_address')::text as IP_ADDRESS    
  FROM @AGS_GAME_AUDIENCE.RAW.UNI_KISHORE_PIPELINE
)
file_format = (format_name = ff_json_logs);

--Run the task to load more rows
execute task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED;
alter task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED resume;
alter task AGS_GAME_AUDIENCE.RAW.LOAD_LOGS_ENHANCED suspend;



select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT
'DNGW06' as step
 ,(
   select CASE WHEN pipe_status:executionState::text = 'RUNNING' THEN 1 ELSE 0 END 
   from(
   select parse_json(SYSTEM$PIPE_STATUS( 'ags_game_audience.raw.GET_NEW_FILES' )) as pipe_status)
  ) as actual
 ,1 as expected
 ,'Pipe exists and is RUNNING' as description
 ); 



drop schema AGS_GAME_AUDIENCE.CURATED;
create schema AGS_GAME_AUDIENCE.CURATED;




select GRADER(step, (actual = expected), actual, expected, description) as graded_results from
(
SELECT
'DNGW07' as step
 ,(
   select 1 
  ) as actual
 ,1 as expected
 ,'We hope you learned about dashboards' as description
 ); 
