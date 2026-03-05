SELECT w.Warehouse_ID, w.City, ROUND(AVG(s.Delay_Hours), 2) AS Average_Delay_Hours
FROM internshala.shipments s
JOIN Warehouses w ON s.Warehouse_ID = w.Warehouse_ID
GROUP BY w.Warehouse_ID, w.City
ORDER BY Average_Delay_Hours DESC
LIMIT 3;

SELECT w.Warehouse_ID, w.City, COUNT(s.Shipment_ID) AS Total_Shipments,SUM(CASE WHEN s.Delay_Hours > 0 THEN 1 ELSE 0 END) AS Delayed_Shipments,
ROUND((SUM(CASE WHEN s.Delay_Hours > 0 THEN 1 ELSE 0 END) / COUNT(s.Shipment_ID)) * 100, 2) AS Delay_Rate_Percentage
FROM internshala.shipments s
JOIN Warehouses w ON s.Warehouse_ID = w.Warehouse_ID
GROUP BY w.Warehouse_ID, w.City
ORDER BY Total_Shipments DESC;

SELECT RANK() OVER (ORDER BY (SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) / COUNT(*)) DESC) AS `Rank`,w.Warehouse_ID, w.City, 
ROUND((SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS On_Time_Percentage,
SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) AS On_Time_Shipments,
COUNT(*) AS Total_Shipments
FROM internshala.shipments s
JOIN Warehouses w ON s.Warehouse_ID = w.Warehouse_ID
GROUP BY w.Warehouse_ID, w.City
ORDER BY On_Time_Percentage DESC;