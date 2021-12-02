/*

Cleaning Data in SQL Queries

*/

 ---------------------------------------------------------------------------------------------------

/* lets take look at data first */

select * from Walmart_sales..sales_table

---------------------------------------------------------------------------------------------------
/* lets search for null values in data */


/* In dataset weight and OutletSize these two columns Contains Null Values */

select count(*) as null_cout_weight from Walmart_sales..sales_table where Weight is null


select count(*) as null_cout_OutletSize from Walmart_sales..sales_table where OutletSize is null

---------------------------------------------------------------------------------------------------------

/*lets impute(fill) the null valeus for Weight column */

select ProductID,Weight from Walmart_sales..sales_table where ProductID = 'FDA15'

/* evry uniqye ProductID have same weight so will use ProductID column for filling null values in weight column */

select a.ProductID ,a.Weight , b.ProductID, b.Weight from Walmart_sales..sales_table a join
Walmart_sales..sales_table b on a.ProductID = b.ProductID where b.Weight is null

/* will update the original table using UPDATE statement */

update b 
SET Weight = ISNULL(b.Weight,a.Weight)
from Walmart_sales..sales_table a join Walmart_sales..sales_table b 
 on a.ProductID = b.ProductID where b.Weight is null AND a.Weight is NOT NULL

----------------------------------------------------------------------------------------------------------------
select count(*) from Walmart_sales..sales_table where weight is null

/* still only 4 rows contain null values weight column so will delete this 4 rows */

delete from Walmart_sales..sales_table where weight is null

---------------------------------------------------------------------------------------------------------------

/* there are some irregular data entries for FatContent Column will update it with correct values */

select Distinct FatContent  from Walmart_sales..sales_table /* Low Fat reg LF Regular */

update Walmart_sales..sales_table set FatContent = 'Regular' where  FatContent = 'reg'

update Walmart_sales..sales_table set FatContent = 'Low Fat' where  FatContent = 'LF'

--------------------------------------------------------------------------------------------------------------

/* Now only Outletsize column contains null value, wili work on it now*/


/* for all OutletType as Grocery Store have OutletSize as Small */

select Distinct OutletSize, OutletType from Walmart_sales..sales_table where OutletType = 'Grocery Store'

Update Walmart_sales..sales_table set OutletSize = 'Small' where OutletType = 'Grocery Store' and OutletSize is null


/* for all LocationType as Tier 2 have OutletSize as Small */

select OutletSize, LocationType from Walmart_sales..sales_table where OutletSize is null and LocationType = 'Tier 2'

select Distinct OutletSize from Walmart_sales..sales_table where LocationType = 'Tier 2'

update Walmart_sales..sales_table set OutletSize = 'Small' where LocationType = 'Tier 2' and OutletSize is null

--------------------------------------------------------------------------------------------------------------------------

select * from Walmart_sales..sales_table 


/* Now data looks clean with no null value and with no irregular and wrong data entries. */ 



/* Data Analysis with SQL Server */

/* lets take a look at given data */

select * from Walmart_sales..sales_table

----------------------------------------------------------------------------------------------------------------------------------------------------
/* fetching the data for Diary products*/

select * from Walmart_sales..sales_table where ProductType = 'Dairy' order by OutletID

-------------------------------------------------------------------------------------------------------------------------------------------------

/* finding out the sum of total sales of Diary products for OUT010 outlet */

select sum(OutletSales) as Total_Dairy_Product_Sales_OUT010 from Walmart_sales..sales_table where ProductType = 'Dairy' and OutletID = 'OUT010'

-----------------------------------------------------------------------------------------------------------------------------------------------------

/* fetching data for sum of total sales for outlets and ording them in descending oreder */

select OutletID, sum(OutletSales) as Total_sales from Walmart_sales..sales_table group by OutletID order by Total_sales desc

------------------------------------------------------------------------------------------------------------------------------------------------------

/* fetching data for sum of total sales by grouping the product types */

select ProductType, sum(OutletSales) as ProductType_sales from Walmart_sales..sales_table group by ProductType order by ProductType_sales desc

---------------------------------------------------------------------------------------------------------------------------------------------------------

/* fetching the top 10 product type sales for outlet OUT010 */

select top 10 ProductType, sum(OutletSales) as total_sales_OUT010_ProductType from Walmart_sales..sales_table 
where OutletID = 'OUT010' group by ProductType order by total_sales_OUT010_ProductType desc

-------------------------------------------------------------------------------------------------------------------------------------------------------------

/* fetching data using subquery for productID, FatContent and ProductType where ProductType MRP is between 1 and 200 and ordering the result data by productID */

select ProductID,FatContent,ProductType from Walmart_sales..sales_table 
where ProductType in ( select ProductType from Walmart_sales..sales_table where MRP between 1 and 200 ) order by ProductID

------------------------------------------------------------------------------------------------------------------------------------------------------------------




