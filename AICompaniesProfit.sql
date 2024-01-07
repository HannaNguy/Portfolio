SELECT TOP (1000) [Company_Name]
      ,[Sector]
      ,[Profits_in_USD]
      ,[AI_Benefits]
  FROM [AIcompanyprofit].[dbo].[AICompaniesProfit]
  --Avg profit for the different AI benefits in the retail sector--
SELECT AI_Benefits, ROUND(AVG(Profits_in_USD), 2) AS AverageProfits
FROM AICompaniesProfit
WHERE Sector = 'Retail'
GROUP BY AI_Benefits
ORDER BY 2 DESC
--Comparison of AI Benefits Distribution in different sectors--
SELECT Sector, AI_Benefits, COUNT(*) AS CompanyCount
FROM AICompaniesProfit
WHERE Sector IN ('Retail', 'Technology')
GROUP BY Sector, AI_Benefits
ORDER BY Sector, CompanyCount DESC
--Outliers in profits--
SELECT Company_Name, Profits_in_USD
FROM AICompaniesProfit
WHERE Sector = 'Retail' AND Profits_in_USD > (SELECT 1.5 * AVG(Profits_in_USD) FROM AICompaniesProfit WHERE Sector = 'Retail')
ORDER BY Profits_in_USD DESC