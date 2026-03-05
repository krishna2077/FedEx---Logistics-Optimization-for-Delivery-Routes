SELECT Route_ID, ROUND(AVG(TIMESTAMPDIFF(SECOND, Pickup_Date, Delivery_Date) / 3600.0), 2) AS Average_Transit_Time_Hours
FROM internshala.shipments
GROUP BY Route_ID
ORDER BY Average_Transit_Time_Hours DESC;

SELECT Route_ID, ROUND(AVG(Delay_Hours), 2) AS Average_Delay_Hours
FROM internshala.shipments
GROUP BY Route_ID
ORDER BY Route_ID ASC;

SELECT Route_ID, Source_City, Destination_City, Distance_KM, Avg_Transit_Time_Hours,
ROUND((Distance_KM / Avg_Transit_Time_Hours), 2) AS Efficiency_Ratio
FROM internshala.routes
ORDER BY Efficiency_Ratio DESC;

SELECT Route_ID, Source_City, Destination_City, Distance_KM, Avg_Transit_Time_Hours,
ROUND((Distance_KM / Avg_Transit_Time_Hours), 2) AS Efficiency_Ratio
FROM internshala.routes
ORDER BY Efficiency_Ratio ASC LIMIT 3;
