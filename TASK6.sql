SELECT Shipment_ID, Delivery_Status, Delivery_Date FROM Shipments
WHERE (Shipment_ID, Delivery_Date) IN (
SELECT Shipment_ID, MAX(Delivery_Date)
FROM internshala.shipments
GROUP BY Shipment_ID)
ORDER BY Delivery_Date DESC;

SELECT Delay_Reason, COUNT(Shipment_ID) AS Frequency,
ROUND(COUNT(Shipment_ID) * 100.0 / (SELECT COUNT(*) FROM Shipments WHERE Delay_Hours > 0), 2) AS Percentage
FROM internshala.shipments
WHERE Delay_Hours > 0 AND Delay_Reason IS NOT NULL
GROUP BY Delay_Reason
ORDER BY Frequency DESC;

SELECT Shipment_ID, Order_ID, Route_ID, Warehouse_ID, Delay_Hours, Delay_Reason, Delivery_Status
FROM internshala.shipments
WHERE Delay_Hours > 120
ORDER BY Delay_Hours DESC;


