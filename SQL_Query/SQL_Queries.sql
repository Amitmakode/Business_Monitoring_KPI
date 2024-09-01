-- Creating the Database;
Create database BizLive_Project;

use BizLive_Project;


-- Creating the Business_information table.
CREATE TABLE `Business_info` (
	`Business_id` VARCHAR(13) NOT NULL, 
	`Business_Name` VARCHAR(121) NOT NULL, 
	`Contact_person` VARCHAR(106), 
	`Local_Address` VARCHAR(90), 
	`City` VARCHAR(13) NOT NULL, 
	`Pincode` DECIMAL(38, 0) NOT NULL, 
	`State` VARCHAR(14) NOT NULL, 
	`GST_Number` VARCHAR(16) NOT NULL,
    primary key (Business_id)
);

-- Loading the file
load data infile
"D:\Business_info.csv"
into table Business_info
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


-- Checking for the data 
select * from Business_info;

-- Converting the pincode into interger.
Alter table Business_info
modify column Pincode INT(7) Not Null;

Select City,State,count(*) as num
from Business_info
Group by City,State;

-- Extending the limit of State value.
Alter table Business_info
modify column `State` VARCHAR(35) Not Null;


-- Checking and correcting the city and state values. 
-- Updating the Business_info Table City column with proper State name.
update Business_info
SET State =
 CASE 
    WHEN City IN ('Akola', 'Amravati', 'Aurangabad', 'Bhandara', 'Chandrapur','Gadchiroli', 'Gondia', 'Nagpur', 'Wardha', 'Yavatmal') THEN 'Maharashtra'
    WHEN City IN ('Bhopal', 'Indore', 'Ujjain',"Chindwada",'Chhindwara','Betul') THEN 'Madhya Pradesh'
    WHEN City IN ('Bilaspur', 'Raipur', 'Korba') THEN 'Chhattisgarh' -- Add entries for other states if applicable
    WHEN City IN ('Nanded', 'Nashik', 'Pune', 'Solapur', 'Kolhapur', 'Sangli', 'Satara') THEN 'Maharashtra'  -- Add Nashik and Solapur
    WHEN City = 'Kochi' THEN 'Kerala'
    WHEN City IN ('Visakhapatnam', 'Vizianagaram') THEN 'Andhra Pradesh'
    WHEN City = 'Shegaon' THEN 'Maharashtra'
    WHEN City = 'Murtizapur' THEN 'Maharashtra'
    WHEN City = 'Sagar' THEN 'Madhya Pradesh'
    WHEN City = 'Butibori' THEN 'Maharashtra'
    WHEN City IN ('Mumbai', 'Navi Mumbai', 'Thane') THEN 'Maharashtra'
    WHEN City = 'Basti' THEN 'Uttar Pradesh'
    WHEN City = 'Nagthana' THEN 'Maharashtra'
    WHEN City = 'Khamgaon' THEN 'Maharashtra'
    WHEN City IN ('Delhi', 'Panipat') THEN 'Delhi'  -- Assuming these belong to Delhi NCR
    WHEN City = 'Ramtek' THEN 'Maharashtra'
    WHEN City = 'Hoshangabad' THEN 'Madhya Pradesh'
    WHEN City = 'Kanhan' THEN 'Maharashtra'
    WHEN City = 'Warthi' THEN 'Maharashtra'
    WHEN City = 'Kalmeshwar' THEN 'Maharashtra'
    WHEN City = 'Jodhpur' THEN 'Rajasthan'
    WHEN City = 'Kamptee' THEN 'Maharashtra'
    WHEN City = 'Saoner' THEN 'Maharashtra'
    WHEN City = 'Badnera' THEN 'Maharashtra'
    WHEN City = 'Samudrapur' THEN 'Maharashtra'
    WHEN City = 'Umrer' THEN 'Maharashtra'
    WHEN City IN ('Ichalkaranji', 'Satara') THEN 'Maharashtra'  -- Assuming Ichalkaranji belongs to Satara district
    When City in ('Ahmednagar','Beed','Pandurana','Chikhaldara','Paratwada','Sangamner','Ganeshpur','Katol','Karanja','Old Jalna')Then 'Maharashtra'
	When City = "Chattisgarh" Then 'Chattisgarh'
	When City = "Surat" Then "Gujrat"
	When City in ('Gwalior') Then "Madhya Pradesh"
	When City = "Jammu" Then "Jammu and Kashmir"
	When City = "Khokurala" Then "Rajasthan"
    When City = "Bela" Then "Maharashtra"
    ELSE 'No Data'
    End;
    
    
    -- Creating the second table Meeting_Data;
    CREATE TABLE `Meeting_Data` (
	`Business_id` VARCHAR(13) NOT NULL, 
	`Telecaller_name` VARCHAR(16) NOT NULL, 
	`BDM_name` VARCHAR(21) NOT NULL, 
	`Calling_Date` VARCHAR(10) NOT NULL, 
	`Meeting_Date` VARCHAR(10) NOT NULL, 
	`Meeting_Time` VARCHAR(15) NOT NULL, 
	`Meeting_Status` VARCHAR(12) NOT NULL,
    foreign key(Business_id) references Business_info(Business_id)
);

select * 
from Meeting_Data;

-- Converting the  Calling_date and Meeting_date and Meeting_time column to their respective formate.alter
-- (1) For Calling_Date column 
 UPDATE `Meeting_Data`
SET `Calling_Date` = STR_TO_DATE(`Calling_Date`, '%d-%m-%Y');

-- (2) For Meeting_Date column
UPDATE `Meeting_Data`
SET `Meeting_Date` = STR_TO_DATE(`Meeting_Date`, '%d-%m-%Y');


-- (3) For Meeting_Time column
ALTER TABLE `Meeting_Data`
MODIFY COLUMN `Meeting_Time` TIME NOT NULL;


-- (4) Converting the Calling_Date into date data type.
ALTER TABLE `Meeting_Data`
modify column `Calling_Date` Date not null;

-- (5) Converting the Meeting_Date into date data type.
ALTER TABLE `Meeting_Data`
modify column `Meeting_Date` Date not null;

-- (6) 
select Meeting_Status,count(*) as c
from Meeting_Data
group by Meeting_Status
order by c desc;

update Meeting_Data
set Meeting_Status =
CASE
	When Meeting_Status in ("Confirm"," Confirm") Then "Confirm"
    When Meeting_Status in ("Call And Go","Call and Go") Then "Call And Go"
    else "No Data"
    end;

/****************************************************************************************************************/

-- Creating the Business_Category Table.
CREATE TABLE `Business_Category_Table11` (
	`Business_id` VARCHAR(13) NOT NULL, 
	`Business_Category` VARCHAR(115) NOT NULL, 
	`Category_type` VARCHAR(55) NOT NULL, 
	`Map` VARCHAR(11) NOT NULL, 
	`Product_proposal` VARCHAR(42) NOT NULL, 
	`New_Product` VARCHAR(43) NOT NULL,
    foreign key(Business_id) references Business_info(Business_id)
);

select * 
from business_category_table11;

-- Creating the Business_Sales Table
CREATE TABLE `Business_Sales` (
	`Business_id` VARCHAR(13) NOT NULL, 
	`Login_Date` VARCHAR(10) NOT NULL, 
	`Sales_Amount` DECIMAL(38, 0) NOT NULL, 
	`Advanced_Amount` DECIMAL(38, 0) NOT NULL, 
	`GST_Amount` DECIMAL(38, 2) NOT NULL, 
	`Payment_mode` VARCHAR(12) NOT NULL,
    foreign key(business_id) references Business_info(Business_id)
);

-- Turning off the foreign key
Set foreign_key_Checks=0;

load data infile
"D:\Business_Sales1.1.csv"
into table Business_Sales
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select *
from business_sales;

-- Turning on the foreign key
Set FOREIGN_KEY_CHECKS = 1;

-- Converting the Login_date column in proper date format.
UPDATE `Business_Sales`
SET `Login_Date` = STR_TO_DATE(`Login_Date`, '%d-%m-%Y');

-- converting the data type into date format
alter table `Business_Sales`
modify column `Login_Date` Date not null;


/*****************************************************************************************/
-- Adding Expense Column in Business_Sales table
Alter table Business_Sales
Add column Expense DECIMAL(38,2);

-- After Creating the Expense Column Storing the value in it which is 70% of Sales_Amount
update Business_Sales
Set Expense = 0.7*Sales_Amount;

/********************************************************************************************************/
-- Creating the profit column in Business_Sales table.
Alter Table Business_Sales
Add column Profit Decimal(38,2); 

-- After Creating the Profit column storing the value in it which is 30% of Sales_Amount
update Business_Sales
Set Profit = 0.3*Sales_Amount;

/**************************************************************************************************************/

-- Retreiving the Business_Sales Data
select * 
from Business_Sales;


-- Problem Statements.
-- 	1. What is the demographic profile of the clients and how does it vary across districts ?
select City,State,Count(*) as Client_Count
from Business_info
group by City,State
order by Client_Count desc;

/*
Insight :-
The city with the highest number of clients is likely to be Nagpur, followed by Bhopal, and Chandrapur.
These cities show a significant concentration of clients, indicating potentially higher business activity 
or better market penetration in these areas.
*/


/* (2) How the Biz have performed over the years. Give their detailed analysis year & month-wise.*/
Select Month(Login_Date) as Month,YEAR(Login_Date) as Year, sum(Sales_Amount) as Total_Sales
from Business_Sales
group by YEAR(Login_Date),Month(Login_Date) 
order by Year,Total_Sales Desc;
/*
Insight :-
Biz performed in most in November 2019, December 2019 followed by January 2020. 
*/


/*(3) What are the most common types of clients and how do they differ in terms of usage and profitability? */
SELECT bc.Business_Category, COUNT(*) AS client_count, 
       SUM(bs.profit) AS total_profit
FROM Business_Category_Table11 bc
JOIN Business_Sales bs ON bc.Business_id = bs.business_id
GROUP BY bc.Business_Category
ORDER BY client_count desc;

-- OR
-- Query with new Category_type. 
SELECT bc.Category_type, COUNT(*) AS client_count, 
       SUM(bs.profit) AS total_profit
FROM Business_Category_Table11 bc
JOIN Business_Sales bs ON bc.Business_id = bs.business_id
GROUP BY bc.Category_type
ORDER BY client_count desc ,total_profit desc;

/*
Insight :-
Most Common type of client is from Hospital, Clinic ,Real Estate and Educational Classes with high profit amount. 
*/



-- 	4. Which types of product are most frequently used by the clients and what is the overall profitability of the client need?
SELECT bc.product_proposal, COUNT(*) AS usage_count, 
       SUM(bs.profit) AS total_profit
FROM business_category_table11 bc
JOIN Business_Sales bs ON bc.Business_id = bs.business_id
GROUP BY bc.product_proposal
ORDER BY usage_count DESC;

-- OR
-- Query with updated New_Product
SELECT bc.New_Product, COUNT(*) AS usage_count, 
       SUM(bs.profit) AS total_profit
FROM business_category_table11 bc
JOIN Business_Sales bs ON bc.Business_id = bs.business_id
GROUP BY bc.New_Product
ORDER BY usage_count DESC,total_profit desc;

/*
Insight :-
Gmvt product is most used by client having highest usage and most profitable product followed by Social Media Management and Gmvt + Google ads.
*/

-- 5. What are the major expenses of the Biz and how can they be reduced to improve profitability?
Select bi.Business_Name,sum(bs.Profit) as total_profit ,sum(bs.Expense) as Total_Expense
from Business_info bi
inner join Business_Sales bs on bi.Business_id = bs.Business_id
group by bi.Business_Name
order by Total_Expense Desc;

/*
Insight :-
Major Expense is from Ayushman Hospital, Maitreya Developers ,Farme , we should focus on Meeting Confirmation of Customer and 
should reduced cost by searching alternative in market.
*/


-- 6.  What is the client portfolio and how does it vary across different purposes and client segments?
Select bc.Business_Category,count(DISTINCT bi.Business_id) as client_count
from business_category_table11 bc
join business_info bi on bc.Business_id=bi.Business_id
group by bc.Business_Category
order by client_count desc;

-- OR

-- Query with updated new category_type.
Select bc.Category_type,bc.New_Product,count(bi.Business_id) as client_count
from business_category_table11 bc
join business_info bi on bc.Business_id=bi.Business_id
group by bc.Category_type,bc.New_Product
order by client_count desc;
/*
Inshight :-
Maximum Client is in Clinic using GMVt product followed by Hospital then Educationl Classes.
*/

-- 	7. How can the Biz improve its customer service and satisfaction levels?
Select distinct(Bi.Business_Name),m.Telecaller_name,m.BDM_name,m.Meeting_Status,bc.New_Product,(m.Meeting_Date-m.Calling_Date)as Days_Taken_For_Meeting,
bs.Sales_Amount,bs.Profit,bs.Expense
from Business_info bi
join Meeting_Data m on bi.Business_id = m.Business_id
join business_category_table11 bc on bi.Business_id = bc.Business_id
left join Business_Sales bs on bi.Business_id = bs.Business_id
order by Days_Taken_For_Meeting Desc;


-- 	8. Can the Biz introduce new products or services to attract more customers and increase profitability?
	select Category_type,count(distinct New_Product) as Product
    from Business_Category_table11
    group by Category_type
    order by Product desc;
    
    /*
    Insight :-
    Biz should introduce new product related to Clinic , Hospital, Educational Classes for more profit 
    Because clients are havinig more usage in it.
    */
    
    
    

-- 9. How are telecallers role in the sales.
Select md.Telecaller_name,sum(bs.Sales_Amount) as Total_Sales,count(*) as Meeting_taken
from Meeting_Data md
inner join Business_Sales bs on bs.Business_id = md.Business_id
where md.Meeting_Status = 'Confirm'
group by md.Telecaller_name
order by Total_Sales desc;
/*
Insight :-
Mayuri have makes high sales with maximum number of meetings, followed by Shital and Gavrav.
*/


-- 10. What is BDM's indivisual performance with various segments of client. 
SELECT md.BDM_name, bc.Category_type, COUNT(*) AS sales_count
FROM Meeting_Data md
JOIN business_category_table11 bc ON md.business_id = bc.business_id
GROUP BY md.BDM_name, bc.Category_type
order by sales_count desc;
/* 
Insight :-
Dupendra have high sales count in Clinic and Hospital Category_type , followed by
Peter and Vishal in Clinic category_type .

*/

-- 11. How many businesses retain with same or different product.
-- for unique product
SELECT b.Business_id ,b.Business_Name,count(distinct p.New_Product) as Product
FROM business_info b
JOIN business_category_table11 p ON b.Business_ID = p.Business_ID
group by Business_id,Business_Name
order by Product desc;
/* 
Insight :-
Samarth Associates with 4 , Adwani Multispeciality Dental Hospital with 4 , and Bharat Coolers And Furniture with 4 are 
the top-3 businesses which have different retention products.
*/

-- query for both unique and same product
SELECT b.Business_id ,b.Business_Name,count(p.New_Product) as Product
FROM business_info b
JOIN business_category_table11 p ON b.Business_ID = p.Business_ID
group by Business_id,Business_Name
order by Product desc;

/*
Insight :-
Maitreya Developers with 12, Frame with 11, and Pallavi Jewellers with 10 are 
the high top businesses which have both same and different retention products.
*/


-- 12. Which is best selling product and category.
SELECT bc.New_Product,bc.Category_type, COUNT(*) AS sales_count,sum(bs.Sales_Amount)as Sales_amount
FROM business_category_table11 bc
join business_sales bs on bc.Business_id = bs.Business_id
GROUP BY New_Product,Category_type
ORDER BY sales_count DESC, Sales_amount
LIMIT 1;

/*
Insight :-
"Hospital" is the top ranker Category_type , and from Product "Gmvt" is the top ranker product which have maximum Sales_Amount.
*/

-- 13. What is popular selling amount.
Select (Sales_Amount) as popular_selling_amount,count(*) as number_count
from Business_Sales
group by popular_selling_amount
order by number_count desc
limit 1;

/*
Insight :-
The most popular selling amount is 10000 with count of 233. 
*/

---------------------------------------------------------------------------------------------------------

