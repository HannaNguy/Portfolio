--Join lottery winners table with store owners and finding total win amount--
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
            
--adding new column for dates with delimiter--
ALTER TABLE Winners
ADD COLUMN Paid_month
ALTER TABLE Winners
ADD COLUMN Paid_day
ALTER TABLE Winners
ADD COLUMN Paid_year
ALTER TABLE Winners
ADD COLUMN Position
UPDATE Winners
SET Position = instr(Paid_date,'/')
UPDATE Winners
SET Paid_month = substr(Paid_date, position,-2)
ALTER TABLE Winners
ADD COLUMN Paid_rest
UPDATE Winners
SET Paid_rest = substr(Paid_date, Position+1)
ALTER TABLE Winners
ADD COLUMN Position2
UPDATE Winners
SET Position2 = instr(Paid_rest,'/')
UPDATE Winners
SET Paid_day = substr(Paid_rest, Position2,-2)
UPDATE Winners
SET Paid_year = substr(Paid_rest, position2+1)
            
--Count how many winners in each year of the data--
SELECT Count (*) AS won, Paid_year
FROM Winners
WHERE Prize >=100000
GROUP BY Paid_year
ORDER BY 1 DESC
