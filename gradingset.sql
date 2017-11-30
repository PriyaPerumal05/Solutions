-- ProblemSet<Grading Set>, November <30> <2017> 
-- Submission by <priya.a.perumal@accenture.com>  


/*1. Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.*/

select CustomerId, FirstName,LastName ,Country from Customer where Country<>'USA';


/*2. Provide a query only showing the Customers from Brazil.*/

select * from Customer where Country='Brazil';


/*3.Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.*/

select Firstname,Lastname,InvoiceID,InvoiceDate,BillingCountry from Customer c join Invoice i on c.CustomerId=i.CustomerId where Country='Brazil';


/*4.Provide a query showing only the Employees who are Sales Agents.*/

select * from Employee where Title like '%Sales%Agent';


/*5.Provide a query showing a unique/distinct list of billing countries from the Invoice table.*/

select distinct BillingCountry from Invoice;


/*6. Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.*/

select e.FirstName,e.LastName ,i.InvoiceId from Invoice i join Customer c on i.CustomerId=c.CustomerId join Employee e on c.SupportRepId=e.EmployeeId group by i.InvoiceId;


/*7. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.*/

select i.Total as InvoiceTotal,c.FirstName,c.Country,e.FirstName from Invoice i,Customer c,Employee e where i.CustomerId=c.CustomerId and e.EmployeeId=c.SupportRepId;


/*8.How many Invoices were there in 2009 and 2011?*/

select count(*) from Invoice where InvoiceDate like '2009%' or InvoiceDate like '2011%';


/*9.What are the respective total sales for each of those years?*/

select Total from Invoice where InvoiceDate like '2009%' or InvoiceDate like '2011%';


/*10.Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.*/

select count(InvoiceLineId) from InvoiceLine where InvoiceID=37;


/*11. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY*/

select InvoiceId,count(InvoiceLineId) from InvoiceLine group by InvoiceID;


/*12.Provide a query that includes the purchased track name with each invoice line item.*/

select t.Name from Track t join InvoiceLine i on t.TrackId=i.TrackId;


/*13.Provide a query that includes the purchased track name AND artist name with each invoice line item.*/

select t.Name as track_name,a.Name as artist_name from InvoiceLine i join Track t on i.TrackId=t.TrackId join Album al on t.AlbumId=al.AlbumId join Artist a on al.ArtistId=a.ArtistId;


/*14.Provide a query that shows the # of invoices per country. HINT: GROUP BY*/

select count(*),BillingCountry from Invoice group by BillingCountry;


/*15.Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.*/

select count(*),p.Name from Playlist p join PlaylistTrack pt on p.PlaylistId=pt.PlaylistId group by p.PlaylistId;


/*16. Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.*/

select t.TrackID,t.Name,al.Title,m.Name,g.Name from Track t,Album al,Genre g,MediaType m where t.AlbumId=al.AlbumId and t.MediaTypeId=m.MediaTypeId and t.GenreId=g.GenreId;


/*17. Provide a query that shows all Invoices but includes the # of invoice line items.*/

select count(InvoiceLineId) as Invoices from Invoice i join InvoiceLine il on i.InvoiceId=il.InvoiceId group by i.InvoiceId;


/*18.Provide a query that shows total sales made by each sales agent.*/

select sum(i.Total),e.FirstName as Employee_Name from Invoice i join Customer c on i.CustomerId=c.CustomerId join Employee e on c.SupportRepId=e.EmployeeId group by EmployeeId;


/*19.Which sales agent made the most in sales in 2009?
Hint: Use the MAX function on a subquery.*/
 
select b.Employee_Name,max(b.sales) from (select sum(i.Total) as sales,e.FirstName as Employee_Name from Invoice i join Customer c on i.CustomerId=c.CustomerId join Employee e on c.SupportRepId=e.EmployeeId group by EmployeeId having i.InvoiceDate like '2009%')as b;


/*20.Which sales agent made the most in sales over all?*/

select b.Employee_Name,max(b.sales) from (select sum(i.Total) as sales,e.FirstName as Employee_Name from Invoice i join Customer c on i.CustomerId=c.CustomerId join Employee e on c.SupportRepId=e.EmployeeId group by EmployeeId )as b;


/*21.Provide a query that shows the count of customers assigned to each sales agent.*/

select e.FirstName,count(c.CustomerId) as Customers from Customer c join Employee e on c.SupportRepId=e.EmployeeId group by e.EmployeeId;


/*22. Provide a query that shows the total sales per country.*/

select sum(Total) as Total_Sales,BillingCountry as Country from Invoice group by BillingCountry;


/*23.Which country's customers spent the most?*/

select max(Total_Sales),Country from(select sum(Total) as Total_Sales,BillingCountry as Country from Invoice group by BillingCountry);


/*24. Provide a query that shows the most purchased track of 2013.*/

select t.TrackId,t.Name from Track t join InvoiceLine il on t.TrackId=il.TrackId join Invoice i on il.InvoiceId=i.InvoiceId where i.InvoiceDate like '%2013%';


/*25.Provide a query that shows the top 5 most purchased tracks over all.*/

select t.TrackId,t.Name,count(il.InvoiceLineId) from Track t join InvoiceLine il on t.TrackId=il.TrackId group by t.Name order by count(il.InvoiceLineId) desc Limit 5;


/*26.Provide a query that shows the top 3 best selling artists.*/

select ar.Name,count(il.InvoiceLineId) from  InvoiceLine il  join Track t on t.TrackId=il.TrackId join Album al on t.AlbumId=al.AlbumId join Artist ar on al.ArtistId=ar.ArtistId group by ar.Name order by count(il.InvoiceLineId) desc Limit 3;


/*27. Provide a query that shows the most purchased Media Type.*/

select max(Media_Type),m.name from (select count(i.InvoiceLineId) as Media_Type,m.name from InvoiceLine i,Track t,MediaType m where i.Trackid=t.Trackid and t.MediaTypeId=m.MediaTypeId group by m.Name);




















