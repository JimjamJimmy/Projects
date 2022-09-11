SELECT * INTO #combinedperson0 from [HumanResources].[Employee] -- unused as of yet
SELECT * INTO #tempemployee FROM [HumanResources].[Employee]
SELECT * INTO #tempaddress1 FROM [Person].[BusinessEntityAddress]
SELECT * INTO #tempaddress2 FROM [Person].[Address]
select * into #temppayy from [HumanResources].[EmployeePayHistory]
-- querying * is unnecessary for any of these, this is only ok when querying 
-- a small database from my own pc.
-- all entries are wasted computing resources, remnants of early explorative code.

if OBJECT_ID ('tempdb.dbo.#combinedperson1') is not NULL
drop table #combinedperson1
select a.*, b.Rate into #combinedperson1
from #combinedperson0 a
 left join #temppayy b on a.BusinessEntityID = b.businessentityid
 select * from #combinedperson1
 --add rate to person data

 if OBJECT_ID ('tempdb.dbo.#combinedaddress') is not NULL
drop table #combinedaddress
select a.businessentityid, b.city into #combinedaddress
from #tempaddress1 a left join #tempaddress2 b on a.AddressID = b.AddressID 
select * from #combinedaddress
-- create city table compatible with person table

if OBJECT_ID ('tempdb.dbo.#combinedperson2') is not NULL
drop table #combinedperson2
select a.*, b.city into #combinedperson2
from #combinedperson1 a 
left join #combinedaddress b on a.BusinessEntityID = b.BusinessEntityID 
select * from #combinedperson2
-- add new city data to person table

if OBJECT_ID ('tempdb.dbo.#paybycity') is not NULL
drop table #paybycity
select rate, city into #paybycity
from #combinedperson2
select * from #paybycity
--create new table containing only city and pay data

select avg(rate) as average, max(rate)as max, min(rate) as min, city from #paybycity 
group by City

--view data grouped by city

select rate, count(businessentityid) 
over(partition by rate) 
as Employees
from #combinedperson2 
order by Rate desc
--VIEW number of employees at each pay rate

if OBJECT_ID ('tempdb.dbo.#combinedperson3') is not NULL
drop table #combinedperson3
select Rate, count(businessentityid) as Employees 
into #combinedperson3 from #combinedperson2 
group by Rate
--save number of employees at each pay rate

if OBJECT_ID ('tempdb.dbo.#combinedperson4') is not NULL
drop table #combinedperson4
select a.city, b.* into #combinedperson4
from #combinedperson2 a left join #combinedperson3 b on a.rate = b.rate
select * from #combinedperson4 
order by Rate desc -- Display highest wages, city they are from, and number of 
--employees at the same pay rate.


select * from #combinedperson4
SELECT * from #tempaddress2
SELECT * from #tempaddress1 -- debugging remnants
