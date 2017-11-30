-- ProblemSet<Problem Set5>, November <30> <2017> 
-- Submission by <priya.a.perumal@accenture.com>  



/*1.Give the organiser's name of the concert in the Assembly Rooms after the first of Feb, 1997. (1 point possible)*/

select m.m_name from musician m join concert c on m.m_no=c.concert_organiser where concert_venue='assembly rooms' and con_date>01/02/97;



/*2.Find all the performers who played guitar or violin and were born in England. (1 point possible)*/

select m.m_name from performer p join musician m on m.m_no=p.perf_is join place pl on pl.place_no=m.born_in where (p.instrument='violin' or p.instrument='guitar') and pl.place_country='england';



/*3.List the names of musicians who have conducted concerts in USA together with the towns and dates of these concerts. (1 point possible)*/

select m.m_name,c.con_date,pl.place_town from musician m join concert c on m.m_no=c.concert_organiser join place pl on c.concert_in=pl.place_no where pl.place_country='usa' group by m.m_no;



/*4.How many concerts have featured at least one composition by Andy Jones? List concert date, venue and the composition's title. (1 point possible)*/




/*5.List the different instruments played by the musicians and avg number of musicians who play the instrument. (1 point possible)*/

select instrument,avg(avg_musicians) from (select instrument,count(perf_is) as avg_musicians from performer group by instrument) group by instrument;



/*6.List the names, dates of birth and the instrument played of living musicians who play a instrument which Theo also plays. (1 point possible)*/

select m.m_name,m.born,p.instrument from musician m join performer p on m.m_no=p.perf_is where m.died is null and p.instrument in(select p.instrument from musician m join performer p on m.m_no=p.perf_is where m_name like 'theo%');



/*7.List the name and the number of players for the band whose number of players is greater than the average number of players in each band. (1 point possible)*/

select p.band_id,b.band_name,count(p.player) as no_of_players from band b join plays_in p on b.band_no=p.band_id group by p.band_id having no_of_players >( select avg(no_of_players) from (select count(player) as no_of_players,band_id from plays_in group by band_id));



/*8.List the names of musicians who both conduct and compose and live in Britain. (1 point possible)*/

select distinct(m.m_name) as musician_name from musician m join place p on m.living_in=p.place_no join has_composed hc on m.m_no=hc.cmpr_no join concert c on c.concert_organiser=m.m_no  where p.place_country in('england','scotland','wales');



/*9.Show the least commonly played instrument and the number of musicians who play it. (1 point possible)*/

select * from (select p.instrument,count(perf_is) as no_of_playedinstrument,m.m_name from musician m join performer p on m.m_no=p.perf_is group by p.instrument)as t where t.no_of_playedinstrument in (select min(no_of_playedinstrument) from (select p.instrument,count(perf_is) as no_of_playedinstrument,m.m_name from musician m join performer p on m.m_no=p.perf_is group by p.instrument));



/*10.List the bands that have played music composed by Sue Little; Give the titles of the composition in each case. (1 point possible)*/




/*11.List the name and town of birth of any performer born in the same city as James First.(1 point possible)*/

select m.m_name,p.place_town from musician m join place p on m.born_in=p.place_no where p.place_town in (select p.place_town from musician m join place p on p.place_no =m.born_in where m.m_name='james first');



/*12.Create a list showing for EVERY musician born in Britain the number of compositions and the number of instruments played. (1 point possible)*/

select m.m_name,count(c_no) as no_of_compositions,count(instrument) as no_of_instrument_played from musician m,composition c,performer p where m.m_no=p.perf_is and c.c_in=m.m_no and m.born in('england','scotland','wales') group by m_no ;


/*13.Give the band name, conductor and contact of the bands performing at the most recent concert in the Royal Albert Hall. (1 point possible)*/

select distinct(b.band_name),c.concert_organiser as conductor,b.band_contact from band b join concert c on c.concert_organiser=b.band_contact 
where  c.concert_organiser in(select concert_organiser from concert where concert_venue like'royal albert hall' group by concert_organiser having con_date=max(con_date));



/*14.Give a list of musicians associated with Glasgow. Include the name of the musician and the nature of the association - one or more of 'LIVES_IN', 'BORN_IN', 'PERFORMED_IN' AND 'IN_BAND_IN'. (1 point possible)*/




/*15.Jeff Dawn plays in a band with someone who plays in a band with Sue Little. Who is it and what are the bands? (1 point possible)*/

