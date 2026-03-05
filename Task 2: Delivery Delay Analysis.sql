SELECT Route_ID, ROUND(AVG(Delay_Hours), 2) AS Avg_Delay_Hours
FROM internshala.shipments
GROUP BY Route_ID
ORDER BY Avg_Delay_Hours DESC
LIMIT 10;

SELECT Warehouse_ID, Shipment_ID, Delay_Hours,
RANK() OVER (
PARTITION BY Warehouse_ID 
ORDER BY Delay_Hours DESC
) AS Delay_Rank
FROM internshala.shipments;

SELECT o.Delivery_Type, ROUND(AVG(s.Delay_Hours), 2) AS Average_Delay_Hours
FROM internshala.orders o
JOIN Shipments s ON o.Order_ID = s.Order_ID
GROUP BY o.Delivery_Type;
