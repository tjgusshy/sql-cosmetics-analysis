
## SQL Business Analysis

Esther Cosmetic incorporation has been gathering their data  to know what factors are influencing sales and orders of cosmetics  in the organisation and the data is stored in their database using  postgresql. Since it is a data driven organization, the analysis that will be carried out  will be used to make decisions by the stakeholders.

As a data analyst your job is to analyze the data and give insights to be used to derive  data-driven  decision,  the analysis will be done using postgresql. 

CASE STUDY QUESTIONS

 
What is the total count of each client and products?
What is the total amount each  client spent ?
What is the total order each client  made?
What is the total purchases for each storestate sold?
What is the most purchased cosmetic? 
how many times was it purchased?
How many orders did each client make and which client  made  more orders?
Which storestate has the highest sales?
what is the total purchases?

These are the column headers that will be used to analyse the product and each will be briefly described for easy understanding as w ego along.

Product Codes
Price
Client
Client Code
Orders
Store State

Product codes
 This is the product code of each product
Price
The price of each product
Clients
The name of clients that partronised the organisation
Client code
A distinct identifier for each clients
Orders
 The orders made by each client
Store state
 The state which each store is located.

We will go ahead and analyse the data using SQL(postgre)

## Taking a look at the whole data
select * from ecommerce.cosmetics_2 ;
 ## Answering the questions
 
 ##What is the total count of each client and products?
 select  count(distinct products), count(distinct client)
FROM ecommerce.cosmetics_2;
  
 ##What is the total amount each  client spent ? 
 select tt.client, round(tt.total_spent) as total_spent
 from( select client,sum(cast(right(price,4) as double)) as total_spent
  from ecommerce.cosmetics_2
  group by 1) tt
  order by 2 desc;

 ##What is the total order each client  made? 
select client, sum(orders) as total_orders
from ecommerce.cosmetics_2
group by client
order by 2 desc;

##What is the total purchases for each storestate sold?
select tt.Store_State, round(tt.total_spent) as total_spent
 from( select Store_State, sum(cast(right(price,4) as double)) as total_spent
  from ecommerce.cosmetics_2
  group by 1) tt 
  order by round(tt.total_spent) desc ;
  
 ## What is the most purchased cosmetic? 
select tt.products, max(round(tt.total_spent)) as max_purchase
 from( select products ,sum(cast(right(price,4) as double)) as total_spent
  from ecommerce.cosmetics_2
  group by 1) tt;

##how many times was it purchased?
select client, count(products) as counts
from ecommerce.cosmetics_2
where products = 'masc'
group by 1 
order by 2;

  ##How many orders did each client make and which client  made  more orders?
  select client, count(orders)
  from ecommerce.cosmetics_2
  group by Client
  order by 2 ;
  
  ##Which storestate has the highest sales?
  select sum_prod.Store_State, round(sum_prod.total_spent) as total_sales
  from (select store_state, sum(cast(right(price,4) as double)) as total_spent
  from ecommerce.cosmetics_2 ) sum_prod
  group by 1
  order by  2 desc 
  limit 1;
##what is the total purchases?
  select round(sum_prod.total_spent)
 from (select sum(cast(right(price,4) as double)) as total_spent
  from ecommerce.cosmetics_2 ) sum_prod ;
  
  
  


