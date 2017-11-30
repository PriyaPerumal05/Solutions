-- ProblemSet<Problem Set1>, November <30> <2017> 
-- Submission by <priya.a.perumal@accenture.com>


/*1.List full details of all hotels*/

select * from hotels;


/*2.List full details of all hotels in New York*/

select * from hotel where city='New York';


/*3.List the names and cities of all guests,ordered according to their cities*/

select name,city from guest order by city;


/*4. List all the non-smoking rooms in ascending order of price*/

select * from room where type='N' order by price;


/*5. List the number of hotels there are*/

select count(hotel_no) from hotel;


/*6. List the cities in which the guest live.Each city should be listed only once*/

select distinct(city) from guest;


/*7. List the average price of  a room*/

select avg(price) from room;


/*8. List hotel names,their room numbers,and the type of that room*/

select name,room_no,type from room r join hotel h on r.hotel_no=h.hotel_no;


/*9. List hotel names,booking date,room number for all hotels in new york*/

select name,date_from,date_to,room_no from booking b join hotel h on b.hotel_no=h.hotel_no where city='New York'; 


/*10.What is the number of bookings that started in the month of September*/

select count(guest_no) as no_of_booking from booking where extract(month from date_from)=9;


/*11.List the names and cities of guests who began a stay in New York in August.*/

select g.Name,g.City from guest g  join booking b on g.guest_No=b.guest_No  join hotel h on h.hotel_no=b.hotel_No where h.city='New York' and extract(month from b.date_from)=8;


/*12. List the hotel names and room numbers of any hotel rooms that have not been booked*/

select h.name,r.room_no from hotel h join room r on h.hotel_no=r.hotel_no where h.hotel_no not in (select hotel_no from booking); 


/*13. List the hotel name and city of the hotel with the highest priced room.*/

select h.name,h.city from hotel h join room r on h.hotel_no=r.hotel_no where price=(select max(price) from room);


/*14.List hotel names, room numbers, cities, and prices for hotels that have rooms with prices lower than the lowest priced room in a Boston*/

select h.name,h.city,r.room_no,r.price from hotel h join room r on h.hotel_no=r.hotel_no where r.price<(select min(r.price) from room r join hotel h on h.hotel_no=r.hotel_no where h.city='Boston');


/*15.List the average price of a room grouped by city.*/

select avg(price) from room r join hotel h on r.hotel_no=h.hotel_no group by h.city;

