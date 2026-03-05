SELECT a.Agent_ID, a.Agent_Name, 
ROUND((SUM(CASE WHEN s.Delay_Hours <= 0 THEN 1 ELSE 0 END) / COUNT(s.Shipment_ID)) * 100, 2) AS On_Time_Percentage,
COUNT(s.Shipment_ID) AS Total_Shipments
FROM internshala.shipments s
JOIN internshala.agents a ON s.Agent_ID = a.Agent_ID
GROUP BY a.Agent_ID, a.Agent_Name
HAVING On_Time_Percentage < 85
ORDER BY On_Time_Percentage ASC;

WITH AgentStats AS (SELECT Agent_ID,
(SUM(CASE WHEN Delay_Hours <= 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS On_Time_Pct
FROM internshala.shipments
GROUP BY Agent_ID),
RankedAgents AS (SELECT Agent_ID,
ROW_NUMBER() OVER (ORDER BY On_Time_Pct DESC, Agent_ID) as Rank_Best,
ROW_NUMBER() OVER (ORDER BY On_Time_Pct ASC, Agent_ID) as Rank_Worst
FROM AgentStats)
SELECT CASE WHEN Rank_Best <= 5 THEN 'Top 5 Agents'
ELSE 'Bottom 5 Agents'END AS Group_Category,
ROUND(AVG(da.Avg_Rating), 2) AS Average_Rating,
ROUND(AVG(da.Experience_Years), 2) AS Average_Experience_Years
FROM RankedAgents ra
JOIN internshala.agents da ON ra.Agent_ID = da.Agent_ID
WHERE Rank_Best <= 5 OR Rank_Worst <= 5
GROUP BY Group_Category
ORDER BY Average_Rating DESC;

WITH AgentPerformance AS (SELECT s.Route_ID,s.Agent_ID,a.Agent_Name,
COUNT(s.Shipment_ID) AS Total_Shipments,
SUM(CASE WHEN s.Delay_Hours <= 0 THEN 1 ELSE 0 END) AS On_Time_Shipments,
(SUM(CASE WHEN s.Delay_Hours <= 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(s.Shipment_ID)) AS On_Time_Percentage
FROM internshala.shipments s
JOIN internshala.agents a ON s.Agent_ID = a.Agent_ID
GROUP BY s.Route_ID, s.Agent_ID, a.Agent_Name)
SELECT Route_ID,RANK() OVER (PARTITION BY Route_ID ORDER BY On_Time_Percentage DESC) AS `Rank`,Agent_Name,
ROUND(On_Time_Percentage, 2) AS On_Time_Percentage,Total_Shipments
FROM AgentPerformance
ORDER BY Route_ID, `Rank`;
