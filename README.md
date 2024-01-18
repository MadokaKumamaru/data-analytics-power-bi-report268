# Data Analytics Power BI Report
In this Power BI report (stored as report.pbix), sales data from a medium-sized international retailer was analysed 
to transform it into actionable insights for better decision-making.

## Tables
Four tables have been imported:
1. Orders - from Azure SQL Database. This is a main fact table. It contains information
            about each order, including the order and shipping dates, the customer, store
            and product IDs for associating with dimension tables, and the amount of each
            product ordered. During data cleaning process, Card Nunber column was deleted
            to ensure data privacy, Order Date and Shipping Data columns were split into
            two distinct columns (one with date and one with time), some rows with misssing
            values were removed, and finally some columns were renamed to align with Power
            BI naming conventions.
   
2. Products - from csv file. This is a dimention table. It contains information about each
              product sold by the company, including the product code, name, category, cost
              price, sale price, and weight.During data cleaning process, duplicates in
              Product Code column were removed, Weight column was transformed to ensure that
              the unit alighs with kg, and finally some columns were renamed.

3. Stores - from Azure Blob Storage. This is a dimention table. It contains information about
            each store, including the store code, store type, country, region, and address.
            During data clearning process, some columns were renamed.

4. Customers - from Zip file. This is a dimention table. The Zip file contains three csv files,
               each with the same column format, one for each of the regions in which the company
               operates. These three files were automatically appended by Power BI into one table.
               It contains information about each customer, including name, address, company,
               email address. During data clearning process, Full Name column was crated by
               combining Firt Name and Last Name columns, and some columns were renamed.

5. Dates - This is a dimention table. This was created using a DAX formula:
           Dates = CALENDAR(MIN(Orders[Order Date]), MAX(Orders[Shipping Date])). Then, following
           columns were added: Day of Week, Month Number (i.e. Jan = 1, Dec = 12 etc.),
           Month Name, Quarter, Year, Start of Year, Start of Quarter, Start of Month, Start of Week
           using appropriate DAX formulas.

6. Measures Table - This was created to store measures created using DAX later on.


## Data Model
After all these six tables were imported, sollowing relationships were created to form a star schema:
1. Orders[product_code] to Products[product_code]
2. Orders[Store Code] to Stores[store code]
3. Orders[User ID] to Customers[User UUID]
4. Orders[Order Date] to Dates[date]
5. Orders[Shipping Date] to Dates[date]
All of the above relationships are one-to-many and Orders[Order Date] to Dates[date] was set to be the
active relationship over Orders[Shipping Date] to Dates[date].


## Report Pages
Following report pages were created:
1. Executive Summary
2. Customer Detail
3. Product Detail
4. Stores Map


## Navigation Sidebar
The navigation sidebar contains following buttons at the bottom left corner to swap to the Executive Summary
page, Customer Detail page, Product Detail page, and the Stores Map page respectively.

## Executive Summary Page
The purpose of this page is to give an overview of the company’s performance as a whole. Following visuals were created in this report:
1. Card visuals showing Total Revenue, Total Profit and, Total Orders
2. A graph of revenue against time
3. Donut charts showing revenue by country and store type
4. A bar chart of orders by category
5. KPIs for Quarterly revenue, orders and profit

## Customer Detail Page
This page focuses on customer-level analysis. Following visuals were created in this report:
1. Card visuals for total distinct customers and revenue per customer
2. A line chart of weekly distinct customers
3. A table showing the top 20 customers by total revenue, showing the revenue per customer and the total orders for each customer
4. A donut chart showing number of customers by country, and a bar chart showing number of customers by product category
5. A set of three card visuals showing the name, number of orders, and revenue for the top customer by revenue
6. A date slicer
7. A set of two card visuals showing hte total number of unique customers and the revenue per customer


## Product Detail Page
The purpose of this page is to provide an in-depth look at which products within the inventory are performing well, with the option 
to filter by product and region.
Following visuals were created in this report:
1. Card visuals to show which filters are currently selected
2. Gauge visuals to show how the selected category’s revenue, profit and number of orders are performing against a quarterly target
3. An area chart showing relative revenue performance of each category over time
4. A table showing the top 10 products by revenue in the selected context
5. A scatter graph of quantity ordered against profit per item for products in the current context
6. Card visuals showing the product with the highest revenue and the highest number of orders
Clicking the slicer button at left top corner will open the sidebar for filtering by product category and regions.


## Stores Map Page
On this page a map which allows users to select stores from different regions on the map to check drillthrough page and tooltips.
The drillthrough page to see which of the stores they are responsible are most profitable, as well as which are on track to reach 
their quarterly profit and revenue targets. The tooltips contain gauses for Profit YTD against a profit target of 20% year-on-year 
growth vs. the same period in the previous year.
The drillthrough page contains following visuals:
1. A table showing the top 5 products
2. A column chart showing Total Orders by product category for the store
3. Gauses for Profit YTD against a profit target of 20% year-on-year growth vs. the same period in the previous year
4. A card visual showing the currently selected region


## SQL
Following files were created for people who don't have direct access to Power BI:
1. tables.csv - This CSV file lists all the tables in the Postgres database
2. column_names - This folder contains CSV files with table names which lists
                  all the columns in each table
3. SQLquestions - This folder contains 5 SQL queries and 5 CSV files for each answer to the query
