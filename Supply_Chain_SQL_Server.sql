SELECT * FROM Supply_Chain;

SELECT
SUM(CASE WHEN Product_type IS NULL THEN 1 ELSE 0 END) AS Product_type_nulls,
SUM(CASE WHEN SKU IS NULL THEN 1 ELSE 0 END) AS SKU_nulls,
SUM(CASE WHEN Price IS NULL THEN 1 ELSE 0 END) AS Price_nulls,
SUM(CASE WHEN Availability IS NULL THEN 1 ELSE 0 END) AS Availability_nulls,
SUM(CASE WHEN Number_of_products_sold IS NULL THEN 1 ELSE 0 END) AS Number_of_products_sold_nulls,
SUM(CASE WHEN Revenue_generated IS NULL THEN 1 ELSE 0 END) AS Revenue_generated_nulls,
SUM(CASE WHEN Customer_Gender IS NULL THEN 1 ELSE 0 END) AS Customer_Gender_nulls,
SUM(CASE WHEN Stock_levels IS NULL THEN 1 ELSE 0 END) AS Stock_levels_nulls,
SUM(CASE WHEN Delivery_Lead_time IS NULL THEN 1 ELSE 0 END) AS Delivery_Lead_time_nulls,
SUM(CASE WHEN Order_quantities IS NULL THEN 1 ELSE 0 END) AS Order_quantities_nulls,
SUM(CASE WHEN Shipping_times IS NULL THEN 1 ELSE 0 END) AS Shipping_times_nulls,
SUM(CASE WHEN Shipping_carriers IS NULL THEN 1 ELSE 0 END) AS Shipping_carriers_nulls,
SUM(CASE WHEN Shipping_costs IS NULL THEN 1 ELSE 0 END) AS Shipping_costs_nulls,
SUM(CASE WHEN Supplier_name IS NULL THEN 1 ELSE 0 END) AS Supplier_name_nulls,
SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS Location_nulls,
SUM(CASE WHEN Supplier_Lead_time IS NULL THEN 1 ELSE 0 END) AS Supplier_Lead_time_nulls,
SUM(CASE WHEN Production_volumes IS NULL THEN 1 ELSE 0 END) AS Production_volumes_nulls,
SUM(CASE WHEN Manufacturing_lead_time IS NULL THEN 1 ELSE 0 END) AS Manufacturing_lead_time_nulls,
SUM(CASE WHEN Manufacturing_costs IS NULL THEN 1 ELSE 0 END) AS Manufacturing_costs_nulls,
SUM(CASE WHEN Inspection_results IS NULL THEN 1 ELSE 0 END) AS Inspection_results_nulls,
SUM(CASE WHEN Defect_rates IS NULL THEN 1 ELSE 0 END) AS Defect_rates_nulls,
SUM(CASE WHEN Transportation_modes IS NULL THEN 1 ELSE 0 END) AS Transportation_modes_nulls,
SUM(CASE WHEN Routes IS NULL THEN 1 ELSE 0 END) AS Routes_nulls,
SUM(CASE WHEN Costs IS NULL THEN 1 ELSE 0 END) AS Costs_nulls
FROM Supply_Chain;


WITH CTE_Duplicates AS (
SELECT
*,
ROW_NUMBER() OVER (PARTITION BY
Product_type, SKU, Price, Availability,
Number_of_products_sold, Revenue_generated, Customer_Gender,
Stock_levels, Delivery_Lead_time, Order_quantities, Shipping_times,
Shipping_carriers, Shipping_costs, Supplier_name, Location,
Supplier_Lead_time, Production_volumes, Manufacturing_lead_time,
Manufacturing_costs, Inspection_results, Defect_rates,
Transportation_modes, Routes, Costs
ORDER BY (SELECT NULL)) AS RowNum
FROM Supply_Chain
)
SELECT *
FROM CTE_Duplicates
WHERE RowNum > 1;




SELECT *
FROM Supply_Chain
WHERE Price <= 0 OR Availability < 0;


SELECT 
    SUM(Shipping_costs) AS Total_Shipping_Costs,
    SUM(Revenue_generated) AS Total_Revenue,
    SUM(Shipping_costs) / SUM(Revenue_generated) AS Shipping_to_Revenue_Ratio
FROM Supply_Chain;


SELECT 
    Product_type,
    SUM(Revenue_generated) AS Total_Revenue,
    SUM(Manufacturing_costs) AS Total_Costs,
    (SUM(Revenue_generated) - SUM(Manufacturing_costs)) / SUM(Revenue_generated) AS Profit_Margin
FROM Supply_Chain
GROUP BY Product_type;



SELECT
    Product_type,
    SUM(Number_of_products_sold) / AVG(Stock_levels) AS Inventory_Turnover
FROM Supply_Chain
GROUP BY Product_type;


UPDATE Supply_Chain
SET Shipping_carriers = 'Unknown'
WHERE Shipping_carriers IS NULL;


UPDATE Supply_Chain
SET Price = (SELECT AVG(Price) FROM Supply_Chain)
WHERE Price IS NULL;


SELECT 
    Product_type,
    SUM(Revenue_generated) AS Total_Revenue,
    SUM(Manufacturing_costs) AS Total_Costs,
    (SUM(Revenue_generated) - SUM(Manufacturing_costs)) AS Total_Profit
FROM Supply_Chain
GROUP BY Product_type
ORDER BY Total_Profit DESC;


SELECT *
FROM Supply_Chain
WHERE Shipping_times BETWEEN 5 AND 10
  AND Revenue_generated > 1000
  AND Customer_Gender = 'Female';


SELECT 
    Shipping_carriers,
    SUM(Shipping_costs) AS Total_Shipping_Costs
FROM Supply_Chain
GROUP BY Shipping_carriers;



SELECT 
    Product_type,
    Revenue_generated,
    RANK() OVER (ORDER BY Revenue_generated DESC) AS Revenue_Rank
FROM Supply_Chain;


SELECT
    Product_type,
    Customer_Gender,
    SUM(Number_of_products_sold) AS Total_Sales
FROM Supply_Chain
GROUP BY Product_type, Customer_Gender;


SELECT 
    Delivery_Lead_time,
    AVG(Shipping_costs) AS Average_Shipping_Costs,
    AVG(Revenue_generated) AS Average_Revenue
FROM Supply_Chain
GROUP BY Delivery_Lead_time;


SELECT 
    Product_type,
    Stock_levels,
    CASE 
        WHEN Stock_levels < 100 THEN 'Low Stock'
        WHEN Stock_levels BETWEEN 100 AND 500 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS Stock_Category
FROM Supply_Chain;


SELECT 
    Shipping_carriers,
    AVG(Shipping_times) AS Avg_Shipping_Times,
    AVG(Delivery_Lead_time) AS Avg_Delivery_Lead_Time
FROM Supply_Chain
GROUP BY Shipping_carriers;


SELECT 
    Location,
    SUM(Revenue_generated) AS Total_Revenue
FROM Supply_Chain
GROUP BY Location;



SELECT
    Product_type,
    SUM(Manufacturing_costs) AS Total_Manufacturing_Costs,
    SUM(Revenue_generated) AS Total_Revenue,
    SUM(Revenue_generated) - SUM(Manufacturing_costs) AS Profit
FROM Supply_Chain
GROUP BY Product_type;


SELECT 
    Product_type,
    MAX(Manufacturing_costs) AS Max_Manufacturing_Cost,
    MAX(Revenue_generated) AS Max_Revenue
FROM Supply_Chain
GROUP BY Product_type;


SELECT 
    Product_type,
    SUM(Revenue_generated) AS Total_Revenue,
    SUM(Manufacturing_costs) AS Total_Costs,
    (SUM(Revenue_generated) - SUM(Manufacturing_costs)) / SUM(Revenue_generated) AS Profit_Margin,
    SUM(Manufacturing_costs) / SUM(Revenue_generated) AS Cost_to_Revenue_Ratio
FROM Supply_Chain
GROUP BY Product_type;


SELECT
    Product_type,
    AVG(Shipping_times) AS Avg_Shipping_Times,
    AVG(Delivery_Lead_time) AS Avg_Delivery_Lead_Time
FROM Supply_Chain
GROUP BY Product_type;


SELECT 
    Product_type,
    SUM(Shipping_costs) AS Total_Shipping_Costs,
    SUM(Revenue_generated) AS Total_Revenue,
    (SUM(Shipping_costs) / SUM(Revenue_generated)) AS Shipping_to_Revenue_Ratio
FROM Supply_Chain
GROUP BY Product_type;



SELECT 
    Product_type,
    AVG(Manufacturing_costs) AS Avg_Manufacturing_Costs,
    AVG(Revenue_generated) AS Avg_Revenue,
    AVG(Manufacturing_costs) / AVG(Revenue_generated) AS Cost_to_Revenue_Ratio
FROM Supply_Chain
GROUP BY Product_type;



SELECT 
    Product_type,
    SUM(Manufacturing_costs) AS Total_Costs,
    SUM(Revenue_generated) AS Total_Revenue,
    SUM(Revenue_generated) - SUM(Manufacturing_costs) AS Profit
FROM Supply_Chain
GROUP BY Product_type
HAVING SUM(Revenue_generated) > 10000
ORDER BY Profit DESC;



SELECT 
    Customer_Gender, 
    SUM(Number_of_products_sold) AS Total_Sales, 
    AVG(Price) AS Avg_Price
FROM Supply_Chain
GROUP BY Customer_Gender;



SELECT 
    Supplier_name,
    AVG(Manufacturing_costs) AS Avg_Cost,
    AVG(Supplier_Lead_time) AS Avg_Lead_Time
FROM Supply_Chain
GROUP BY Supplier_name
ORDER BY Avg_Cost DESC;


SELECT 
    Product_type,
    AVG(Manufacturing_costs) AS Avg_Manufacturing_Costs,
    AVG(Shipping_costs) AS Avg_Shipping_Costs
FROM Supply_Chain
GROUP BY Product_type;



SELECT 
    Product_type,
    SUM(Stock_levels) AS Total_Stock
FROM Supply_Chain
GROUP BY Product_type
HAVING SUM(Stock_levels) < 100
ORDER BY Total_Stock ASC;


SELECT 
    Delivery_Lead_time,
    AVG(Shipping_times) AS Avg_Shipping_Times
FROM Supply_Chain
GROUP BY Delivery_Lead_time;



SELECT 
    Supplier_name,
    AVG(Shipping_costs) AS Avg_Shipping_Costs,
    SUM(Shipping_costs) AS Total_Shipping_Cost
FROM Supply_Chain
GROUP BY Supplier_name
ORDER BY Total_Shipping_Cost DESC;


SELECT 
    Product_type,
    SUM(Order_quantities) AS Total_Ordered,
    SUM(Production_volumes) AS Total_Produced
FROM Supply_Chain
GROUP BY Product_type
HAVING SUM(Order_quantities) > SUM(Production_volumes)
ORDER BY Total_Ordered DESC;


SELECT 
    Product_type,
    SUM(Revenue_generated) AS Total_Revenue
FROM Supply_Chain
GROUP BY Product_type
ORDER BY Total_Revenue DESC;


SELECT 
    Supplier_name,
    SUM(Revenue_generated) AS Total_Revenue,
    AVG(Manufacturing_costs) AS Avg_Manufacturing_Cost
FROM Supply_Chain
GROUP BY Supplier_name
ORDER BY Total_Revenue DESC;


SELECT 
    Product_type,
    SUM(Number_of_products_sold) AS Total_Sales,
    SUM(Revenue_generated) AS Total_Revenue,
    (SUM(Revenue_generated) / SUM(Number_of_products_sold)) AS Revenue_Per_Product
FROM Supply_Chain
GROUP BY Product_type
HAVING (SUM(Revenue_generated) / SUM(Number_of_products_sold)) < 10
ORDER BY Revenue_Per_Product;


SELECT 
    Shipping_carriers, 
    AVG(Shipping_times) AS Avg_Shipping_Time
FROM Supply_Chain
GROUP BY Shipping_carriers
ORDER BY Avg_Shipping_Time;



SELECT 
    Product_type,
    SUM(Shipping_costs) AS Total_Shipping_Cost,
    SUM(Revenue_generated) AS Total_Revenue
FROM Supply_Chain
GROUP BY Product_type
HAVING SUM(Shipping_costs) > SUM(Revenue_generated)
ORDER BY Total_Shipping_Cost DESC;


SELECT 
    Supplier_name,
    SUM(Number_of_products_sold) AS Total_Sales
FROM Supply_Chain
GROUP BY Supplier_name
ORDER BY Total_Sales DESC;


SELECT 
    Location,
    AVG(Shipping_costs) AS Avg_Shipping_Cost
FROM Supply_Chain
GROUP BY Location
ORDER BY Avg_Shipping_Cost DESC;


SELECT 
    Inspection_results, 
    SUM(Number_of_products_sold) AS Total_Sales
FROM Supply_Chain
GROUP BY Inspection_results
ORDER BY Total_Sales DESC;



SELECT 
    Product_type,
    AVG(Defect_rates) AS Avg_Defect_Rate
FROM Supply_Chain
GROUP BY Product_type
HAVING AVG(Defect_rates) > 5
ORDER BY Avg_Defect_Rate DESC;



SELECT 
    Product_type, 
    SUM(Stock_levels) AS Total_Stock
FROM Supply_Chain
GROUP BY Product_type
HAVING SUM(Stock_levels) > 1000
ORDER BY Total_Stock DESC;




































