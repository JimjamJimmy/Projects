SELECT * INTO #combinedperson0 from [HumanResources].[Employee] -- unused as of yet
SELECT * INTO #tempemployee FROM [HumanResources].[Employee]
SELECT * INTO #tempaddress1 FROM [Person].[BusinessEntityAddress]
SELECT * INTO #tempaddress2 FROM [Person].[Address]
select * into #temppayy from [HumanResources].[EmployeePayHistory]

select a.*, b.Rate into #combinedperson1
from #combinedperson0 a
 left join #temppayy b on a.BusinessEntityID = b.businessentityid
 select * from #combinedperson1
 --add rate to person data


select a.businessentityid, b.city into #combinedaddress
from #tempaddress1 a left join #tempaddress2 b on a.AddressID = b.AddressID 
select * from #combinedaddress
-- create city table compatible with person table

select a.*, b.city into #combinedperson2
from #combinedperson1 a 
left join #combinedaddress b on a.BusinessEntityID = b.BusinessEntityID 
select * from #combinedperson2
-- add new city data to person table

select rate, city into #paybycity
from #combinedperson2
select * from #paybycity
--create new table containing only city and pay data

select avg(rate) as average, max(rate)as max, min(rate) as min, city from #paybycity 
group by City

--view data grouped by city

select Rate, count(businessentityid) as Employees from #combinedperson2 
group by Rate

--view number of employees at each pay rate

select Rate, count(businessentityid) as Employees into #combinedperson3 from #combinedperson2 
group by Rate
--save number of employees at each pay rate, perhaps more can be achieve later?

select a.city, b.* into #combinedperson4
from #combinedperson2 a left join #combinedperson3 b on a.rate = b.rate
select * from #combinedperson4  --These results are innacurate. Example of a wrong step.


select * from #combinedperson
SELECT * from #tempaddress2
SELECT * from #tempaddress1 -- debugging remnants