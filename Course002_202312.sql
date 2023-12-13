UTIL_DB.PUBLIC.MY_INTERNAL_NAMED_STAGEUTIL_DB.PUBLIC.MY_INTERNAL_NAMED_STAGEUTIL_DB.PUBLIC.MY_INTERNAL_NAMED_STAGEUTIL_DB.PUBLIC.MY_INTERNAL_NAMED_STAGEUTIL_DB.PUBLIC.MY_INTERNAL_NAMED_STAGE--Lesson 1
select current_region();
select current_account();

--Lesson 2-4 - Dora we meet again
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select grader(step, (actual = expected), actual, expected, description) as graded_results from 
  ( SELECT 
  'DORA_IS_WORKING' as step
 ,(select 223) as actual
 , 223 as expected
 ,'Dora is working!' as description
); 


-- Set your worksheet drop lists
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW01' as step
 ,( select count(*) 
   from PC_RIVERY_DB.INFORMATION_SCHEMA.SCHEMATA 
   where schema_name ='PUBLIC') as actual
 , 1 as expected
 ,'Rivery is set up' as description
);



-------------------------
-- Set your worksheet drop lists
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DABW02' as step
 ,( select count(*) 
   from PC_RIVERY_DB.INFORMATION_SCHEMA.TABLES 
   where ((table_name ilike '%FORM%') 
   and (table_name ilike '%RESULT%'))) as actual
 , 1 as expected
 ,'Rivery form results table is set up' as description
);

------------------------------
-- Set your worksheet drop lists

-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW03' as step
 ,( select sum(round(nutritions_sugar)) 
   from PC_RIVERY_DB.PUBLIC.FRUITYVICE) as actual
 , 35 as expected
 ,'Fruityvice table is perfectly loaded' as description
);

--select * from  PC_RIVERY_DB.PUBLIC.FRUITYVICE
--delete from PC_RIVERY_DB.PUBLIC.FRUITYVICE where NAME='Watermelon'

------------------------------
set var1 = 1;
set var2 = 2;
set var3 = 3;
select  $var1 + $var2 + $var3 as VarSummed;
select 'Doug' as Doug


---------------------------------------
set var1 = 1;
set var2 = 2;
set var3 = 3;
select SUM_MYSTERY_BAG_VARS($var1, $var2, $var3 );
select 'Doug' as Doug

---------------------------------------

-- Set these local variables according to the instructions
set this = -10.5 ;
set that = 2;
set the_other = 1000 ;

-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW04' as step
 ,( select util_db.public.sum_mystery_bag_vars($this,$that,$the_other)) as actual
 , 991.5 as expected
 ,'Mystery Bag Function Output' as description
);

---------------------------------------

set alerternating_caps_phrase = 'aLtErNaTiNg CaPs!';
--select $alerternating_caps_phrase;
select initcap($alerternating_caps_phrase);


---------------------------------------
-- Set your worksheet drop lists
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DABW05' as step
 ,( select hash(neutralize_whining('bUt mOm i wAsHeD tHe dIsHes yEsTeRdAy'))) as actual
 , -4759027801154767056 as expected
 ,'WHINGE UDF Works' as description
);

---------------------------------------
show stages in account;
list @my_internal_named_stage;
Select $1 from @my_internal_named_stage/my_file.txt.gz;
------------------------------------


-- Set your worksheet drop lists
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW06' as step
 ,( select count(distinct METADATA$FILENAME) 
   from @util_db.public.my_internal_named_stage) as actual
 , 3 as expected
 ,'I PUT 3 files!' as description
);


----------------------------------------
--  LESSON 12
use role pc_rivery_role;
use warehouse pc_rivery_wh;

create or replace TABLE PC_RIVERY_DB.PUBLIC.FRUIT_LOAD_LIST (
	FRUIT_NAME VARCHAR(25)
);

----------------------------------------
insert into PC_RIVERY_DB.PUBLIC.FRUIT_LOAD_LIST
values ('banana')
, ('cherry')
, ('strawberry')
, ('pineapple')
, ('apple')
, ('mango')
, ('coconut')
, ('plum')
, ('avocado')
, ('starfruit');

----------------
select * from PC_RIVERY_DB.PUBLIC.FRUIT_LOAD_LIST;
---delete from PC_RIVERY_DB.PUBLIC.FRUIT_LOAD_LIST where FRUIT_NAME='jackfruit'

----------------
-- DO NOT EDIT ANYTHING BELOW THIS LINE
select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
   SELECT 'DABW07' as step 
   ,( select count(*) 
     from pc_rivery_db.public.fruit_load_list 
     where fruit_name in ('jackfruit','papaya', 'kiwi', 'test', 'from streamlit', 'guava')) as actual 
   , 4 as expected 
   ,'Followed challenge lab directions' as description
); 
