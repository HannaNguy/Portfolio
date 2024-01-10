SELECT Owner_first, Owner_middle,Owner_last,Owner_city, Owner_county, 
COUNT(*) AS Wins_Ct, 
SUM(Prize) AS Total_Wins
FROM Owners
JOIN Winners ON Owners.Owner_first = Winners.Winner_first
            AND Owners.Owner_middle = Winners.Winner_middle
            AND Owners.Owner_last = Winners.Winner_last
            AND Owners.Owner_city = Winners.Winner_city
            AND Owners.Owner_county = Winners.Winner_county
GROUP BY Owner_first
ORDER BY 6 DESC