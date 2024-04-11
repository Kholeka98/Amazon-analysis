#  Amazon Online Sales Analysis Dashboard

## Project Objective 
Develop a comprehensive dashboard that provides insights into various aspects of Amazon sales data. The dashboard will include visualizations and interactive features to allow users to explore sales, product, and shipping data effectively.

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


## Approach Taken 
1. ### Dataset Preparation
- To enhance data organization and facilitate analysis, the Amazon online sales data was separated into three distinct tables, ensuring that the `order_id` serves as the primary key across all tables:

    - **Sales Information Table**: This table serves as the sales-related data, with each row representing a unique order.It includes details such as the order date, sales channel, B2B 
     status, quantity, amount.

    - **Shipping Details Table**: This table contain shipping-related information, providing 
  insights into the delivery process. It contains data such as the shipping city, shipping 
  state, and zipcode, aiding in geographical analysis and logistics optimization.

    - **Product Details Table**: This table allows for analysis of sales performance at the product level. Key attributes such as product category, size, and fulfillment method (e.g Amazon or merchant) are stored, enabling insights into product popularity and fulfillment preferences.

- Build a database.
- Define a table  and import NOT NULL data into the table.
  
3. ### Feature Engineering
     - Add a new column named ` revenue ` using the metric Revenue = Quantity * Price.
   
## Business Questions to answer
### Product Analysis 
 - What are the top 10 best-selling products overall?
 - Can you identify any seasonal trends in the sales of specific products?
 -  Which product categories generate the highest revenue?
 - Are there any product categories that are consistently underperforming?
 - Do certain product sizes sell better than others?
 -  Are there any correlations between product size and revenue?

### Sales Analysis 
- Which sales channels bring in the most revenue?
- Is there a significant difference in revenue between B2B and B2C sales?
- Are there any trends or patterns in order quantity over time?
- How has revenue changed over time?

### Shipping Analysis 
 - Which cities/states have the highest number of orders?
 - Is there any correlation between shipping location and order value?
 - What percentage of orders use different shipping services?
