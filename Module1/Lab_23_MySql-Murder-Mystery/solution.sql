create database if not exists Murder_mystery;
use Murder_mystery;

-- Finds the names of the tables in database
SELECT name 
  FROM sqlite_master
 where type = 'table';
 
 -- Finds the structure of the 'crime_scene_report' table
 SELECT sql 
  FROM sqlite_master
 where name = 'crime_scene_report';
 
 -- looking through all crime reports
 select *
from crime_scene_report
where date = 20180115 and type = 'murder' ;

-- finds 20180115 => 1 suitable murder	
-- Security footage shows that there were 2 witnesses. 
-- The first witness lives at the last house on "Northwestern Dr". 
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".	SQL City

-- Searching last house on "Northwestern Dr"
 select *
from person
where address_street_name = 'Northwestern Dr' or name = 'Annabel'
group by address_street_name, name
order by address_number desc limit 1
;
-- founds
-- 	name	license_id	address_number	address_street_name	ssn
--   14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949

-- searchin by name Annabel who lives on "Franclin Ave"
select *
from person
where address_street_name = 'Franklin Ave'
group by name
;
-- founds
-- 	name	license_id	address_number	address_street_name	ssn
-- 16371	Annabel Miller	490173	103	Franklin Ave	318771143

-- checking facebook event on the day of murder for each person id
select *
from facebook_event_checkin
where date = '20180115' and person_id = 16371
group by person_id
;
select *
from facebook_event_checkin
where date = '20180115' and person_id = 14887
group by person_id
;
-- both was on 
-- person_id	event_id	event_name	date
-- 16371	4719	The Funky Grooves Tour	20180115

-- checks the interviews
select *
from interview
where person_id = 14887 
group by person_id
;
-- I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag.
-- The membership number on the bag started with "48Z". Only gold members have those *
-- bags. The man got into a car with a plate that included "H42W".
select *
from interview
where person_id = 16371 
group by person_id
;
-- I saw the murder happen, and I recognized the killer from my gym when I was 
-- working out last week on January the 9th.

-- checking membership id 48z  on 20180109
select *
from get_fit_now_check_in
where check_in_date = 20180109
order by membership_id
;
-- membership_id	check_in_date	check_in_time	check_out_time
-- 48Z55	20180109	1530	1700
-- 48Z7A	20180109	1600	1730

-- checking members names by member id
select *
from get_fit_now_member
where id = '48Z55'
;
-- id	person_id	name	membership_start_date	membership_status
-- 48Z55	67318	Jeremy Bowers	20160101	gold
-- 48Z7A	28819	Joe Germuska	20160305	gold

-- checking for facebook events on murder day
select *
from facebook_event_checkin
where date = '20180115' and person_id = 28819
group by person_id
;
-- no events for 48Z7A	28819	Joe Germuska	20160305	gold
-- event for Jeremy

-- looking for license ID For Joe 
select name, license_id
from person
where id = 28819
;
-- licence id 173289
-- licence id for Jeremy 423327

-- looking for car plate
select plate_number, id
from drivers_license
where id = 423327
;
-- no car found for Joe, but 1 car for Jeremy with plate number 0H42W2
              

select * 
from income
where ssn = 138909730; -- 0 joe


select * 
from income
where ssn = 871539279; -- 10500 jeremy
;

-- checking jeremys interview
select *
from interview
where person_id = 67318 
group by person_id
;
-- I was hired by a woman with a lot of money. I don't know her name but 
-- I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she 
-- drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3
-- times in December 2017.

-- checking car 
select *
from drivers_license
where car_model = 'Model S' 
order by hair_color
;
-- id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 291182	65	66	blue	red	female	08CM64	Tesla	Model S
-- 202298	68	66	green	red	female	500123	Tesla	Model S

-- searching in person by driver license
select *
from person
where license_id = 291182

;
-- id	name	license_id	address_number	address_street_name	ssn
-- 90700	Regina George	291182	332	Maple Ave	337169072
-- 99716	Miranda Priestly	202298	1883	Golden Ave	987756388

-- checking facebook
select *
from facebook_event_checkin
where person_id = 99716

;
-- Miranda Priestly went 3 times to Concert and she has 310k on bank account
-- so she is a murderer


              
