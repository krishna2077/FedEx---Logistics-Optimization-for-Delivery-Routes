SELECT Order_ID ,Shipment_ID,COUNT(*)
FROM internshala.shipments
GROUP BY Order_ID,Shipment_ID
HAVING COUNT(*) > 1;

SELECT DATE_FORMAT(Pickup_Date, '%Y-%m-%d %H:%i:%s') AS Pickup_Date, 
DATE_FORMAT(Delivery_Date, '%Y-%m-%d %H:%i:%s') AS Delivery_Date
FROM internshala.shipments;
SELECT DATE_FORMAT(Order_Date, '%Y-%m-%d %H:%i:%s') AS Order_Date
FROM internshala.orders;

SELECT o.* FROM internshala.orders o
LEFT JOIN internshala.warehouses w ON o.Warehouse_ID = w.Warehouse_ID
WHERE w.Warehouse_ID IS NULL;

SELECT s.* FROM internshala.shipments s
LEFT JOIN internshala.orders o ON s.Order_ID = o.Order_ID
WHERE o.Order_ID IS NULL;

SELECT r.* FROM internshala.routes r
LEFT JOIN internshala.warehouses w ON r.Origin_Warehouse_ID = w.Warehouse_ID
WHERE w.Warehouse_ID IS NULL;

