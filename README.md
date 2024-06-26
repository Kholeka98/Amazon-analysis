#  Amazon Online Sales Analysis 
## Project Objective 
In this project, the focus is on conducting a thorough analysis of an Amazon online sales dataset using SQL queries. The dataset contains information on sales, products, and shipping. The primary goal is to extract valuable insights, identify patterns, and uncover trends within the dataset. This analysis aims to provide a comprehensive understanding of the Amazon sales data, enabling stakeholders to make informed decisions based on the findings.

By utilizing SQL's querying capabilities, the project aims to delve deep into the data, exploring various aspects such as sales trends over time, popular products, geographical sales distribution, shipping patterns, and customer behavior. The insights gained from this analysis can be used to optimize sales strategies, improve inventory management, enhance customer experience, and drive business growth.


## About Data 
The dataset was obtained from [Kaggle](https://www.kaggle.com/datasets/thedevastator/unlock-profits-with-e-commerce-sales-data). This is a dataset that contain information about  Amazon online sales.
| Column         | Description                               | Data Type       |
| ---------------|:-----------------------------------------:|:---------------:|
| order_id       | unique identifier assigned to each order  | VARCHAR(30)     |
| Date           | Date of sale                              |  DATE           |
| Category       | Type of product                           | VARCHAR(30)     |
| Size           | size of product                           | VARCHAR(5)      |
| Status         | Status of sale                            | VARCHAR(20)     |
| Fulfilment     | Method of fulfilment                      | VARCHAR(30)     |
| Sales Channel  |Sales channel                              |  VARCHAR(30)    |
| Style          | Style of the product                      | VARCHAR(15)     |
| SKU            | Stock keeping unit                        | VARCHAR(30)     |
| ASIN           | Amazon Standard Identification Number     | VARCHAR(30)     | 
| Courier status | Total sales of product 4                  | VARCHAR(30)     |
|qty             | quantity of product                       | INT             |
| Amount         | Amount of sale                            | FLOAT           |
| B2B            | Business to business sales                |  BOOLEAN        |
|ship_city       | City  order is  shipped to                |   VARCHAR(30)   |
|ship_state      | State order is  shipped to                | VARCHAR(30)     |
|zipcode         | Zipcode  order is  shipped to             |  VARCHAR( 10)   |


## Strategy
### Dataset Preparation
- To avoid data loss, we performed data cleaning in Excel prior to importing the dataset into SQL.
- To enhance data organization and facilitate analysis, the Amazon online sales data was separated into three  tables, ensuring that the `order_id` serves as the primary key across all tables:

    - **Sales Information Table**: This table serves as the sales-related data, with each row representing a unique order.It includes details such as the order date, sales channel, B2B 
     status, quantity, amount.

    - **Shipping Details Table**: This table contain shipping-related information, providing 
  insights into the delivery process. It contains data such as the shipping city, shipping 
  state, and zipcode, aiding in geographical analysis and logistics optimization.

    - **Product Details Table**: This table allows for analysis of sales performance at the product level. Key attributes such as product category, size, and fulfillment are stored, enabling insights into product popularity and fulfillment preferences.
- Data types of each column was checked and corrected appropriately.
- Build an `amazon_online_sales` database.
- Create `amazon_sales`, `amazon_product`, `amazon_shipping` tables  and import NOT NULL data into the tables.
  
### Feature Engineering on SQL
- Add a new column named ` revenue ` calculated as the product of quantity and price.
- Add a new column named ` month_name ` which extracts the month of the week from the date field.
- Add a new column named ` year ` which extracts the year from the date field.


## Business Questions to answer
### Product Analysis
 - What is the total revenue, total quantify sold, and average revenue?
 - What are the top 5 best-selling products overall?
 - Can you identify any trends in the sales of products?
 -  Which product categories generate the highest revenue?
 - Are there any product categories that are consistently underperforming?
 - Do certain product sizes sell better than others?
 -  Are there any correlations between product size and revenue?
 -  Which is the most prefered fulfilment?
   
### Sales Analysis 
- Is there a significant difference in revenue between B2B and B2C sales?
- Are there any trends or patterns in order quantity over time?
- How has revenue changed over time?

### Shipping Analysis 
 - What are the frequencies of the items in  order status per month?
 - Which cities/states have the highest number of orders?
 - What percentage of orders use different shipping services?

## Code
I have attached a file named [Amazon Project](https://github.com/Kholeka98/Amazon-analysis/blob/main/Amazon%20Project.sql) containing the rest of the code.


```sql
-- Create database 
CREATE DATABASE IF NOT EXISTS amazon_online_sales;


-- Create amazon_sales table
CREATE TABLE IF NOT EXISTS amazon_sales (
    Order_id VARCHAR(30) NOT NULL PRIMARY KEY,
    date DATETIME NOT NULL,
    quantity INT NOT NULL,
    amount FLOAT NOT NULL,
    sales_channel VARCHAR(50) NOT NULL,
    B2B BOOLEAN NOT NULL
);

-- Create amazon_product table
CREATE TABLE IF NOT EXISTS amazon_product (
    Order_id VARCHAR(30) NOT NULL PRIMARY KEY,
    category VARCHAR(30) NOT NULL,
    size VARCHAR(30) NOT NULL,
    style VARCHAR(30) NOT NULL,
    fulfilment VARCHAR(30) NOT NULL,
    asin VARCHAR(30) NOT NULL
);

-- Create amazon_shipping table
CREATE TABLE IF NOT EXISTS amazon_shipping (
    Order_id VARCHAR(20) NOT NULL PRIMARY KEY,
    order_status VARCHAR(200) NOT NULL,
    ship_service VARCHAR(200) NOT NULL,
    ship_city VARCHAR(200) NOT NULL,
    ship_state VARCHAR(200) NOT NULL,
    zipcode VARCHAR(30) NOT NULL
);

```

## Summary of  Results
### Key Performance Indicators
- Total Revenue: ₹70,981,787
- Total Quantity Sold: 108,652
- Average Revenue : ₹655.49
  
### Top Selling Product Categories:
| Category         |Total Quantity|  Total Revenue(₹) |
|------------------|:-------------|:---------------|
| Sets             |42440         | 35 522 629     |
| Kurta            | 41367        | 19 021 020     |
| Western Dress    | 13219        | 10 136 839     |
| Top              | 9335         | 4 929 480      |
| Ethnic Dress     |  982         | 706 521        |

### Insights   
- Sets consistently perform well, generating the highest revenue over the four-month period.
- Dupatta consistently underperforms, with revenue below the average.
- Distribution between Amazon and Merchant:
     - Amazon: 72.34%
     - Merchant: 27.66%
      
### Revenue Breakdown
- Business to Customer (B2C) Revenue: ₹70,413,194
- Business to Business (B2B) Revenue: ₹568684
Expressing as a Percentage of Total Revenue:
    - B2C Revenue: 99.20%
    - B2B Revenue: 0.80%
