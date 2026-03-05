SELECT r.Source_Country, AVG(s.Delay_Hours) AS Avg_Delay_Hours,COUNT(s.Shipment_ID) AS Total_Shipments
FROM internshala.shipments s
JOIN internshala.routes r ON s.Route_ID = r.Route_ID
GROUP BY r.Source_Country
ORDER BY Avg_Delay_Hours DESC;

SELECT COUNT(*) AS Total_Shipments,SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) AS On_Time_Deliveries,
ROUND((SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS On_Time_Delivery_Percentage
FROM internshala.shipments;

SELECT Route_ID, ROUND(AVG(Delay_Hours), 2) AS Average_Delay_Hours,COUNT(Shipment_ID) AS Total_Shipments
FROM internshala.shipments
GROUP BY Route_ID
ORDER BY Average_Delay_Hours DESC;


WITH DailyVolume AS (SELECT Warehouse_ID,COUNT(Shipment_ID) AS Total_Shipments_Handled,
DATEDIFF(MAX(Delivery_Date), MIN(Delivery_Date)) AS Days_In_Period,
COUNT(Shipment_ID) / NULLIF(DATEDIFF(MAX(Delivery_Date), MIN(Delivery_Date)), 0) AS Avg_Daily_Shipments
FROM internshala.shipments
GROUP BY Warehouse_ID)
SELECT w.Warehouse_ID, w.City,w.Capacity_per_day,
ROUND(dv.Avg_Daily_Shipments, 2) AS Avg_Daily_Volume,
ROUND((dv.Avg_Daily_Shipments / w.Capacity_per_day) * 100, 2) AS Utilization_Percentage
FROM DailyVolume dv
JOIN internshala.warehouses w ON dv.Warehouse_ID = w.Warehouse_ID
ORDER BY Utilization_Percentage DESC;
