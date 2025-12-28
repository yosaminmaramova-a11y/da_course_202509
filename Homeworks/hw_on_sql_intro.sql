/*
Yosamin Maramova
Homework #31
*/

/*
 2
 */
select 
	name
	, genre_id
from track
;

/*
 3
 */
select
	name as song 
	, unit_price as price
	, composer as author	
from track 
;

/*
4
*/
select
	composer
	,round(milliseconds / 6000.0, 2) as 
duration_in_min
from track
order by duration_in_min
;

/*
 5
 */
select
	name
	, genre_id
from track
limit 15
;

/*
 6
 */
select*
from track
limit 50
;


/*
 7
 */
select
	name
	, bytes
from track
where bytes > 104857600 
;

/*
 8
 */
select
	name 
	,composer
from track 
where composer <>'U2'
limit 10 offset 20
;