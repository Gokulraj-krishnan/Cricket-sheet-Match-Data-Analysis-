-- 1. Total ODI Matches
SELECT COUNT(*) AS total_matches FROM odi_matches;

-- 2. Total ODI Deliveries
SELECT COUNT(*) AS total_deliveries FROM odi_deliveries;

-- 3. Total ODI Runs
SELECT SUM(total_runs) AS total_runs FROM odi_deliveries;

-- 4. Total Wickets in ODI
SELECT SUM(is_wicket) AS total_wickets FROM odi_deliveries;

-- 5. Top 10 ODI Run Scorers
SELECT batter, SUM(runs_batter) AS runs
FROM odi_deliveries
GROUP BY batter
ORDER BY runs DESC
LIMIT 10;

-- 6. Most Sixes
SELECT batter, COUNT(*) AS sixes
FROM odi_deliveries
WHERE runs_batter = 6
GROUP BY batter
ORDER BY sixes DESC
LIMIT 10;

-- 7. Most Fours
SELECT batter, COUNT(*) AS fours
FROM odi_deliveries
WHERE runs_batter = 4
GROUP BY batter
ORDER BY fours DESC
LIMIT 10;

-- 8. Strike Rate (Min 300 Balls)
SELECT batter,
       COUNT(*) AS balls,
       SUM(runs_batter) AS runs,
       ROUND(SUM(runs_batter)*100.0/COUNT(*),2) AS strike_rate
FROM odi_deliveries
GROUP BY batter
HAVING balls >= 300
ORDER BY strike_rate DESC
LIMIT 10;

-- 9. Top 10 Wicket Takers
SELECT bowler, SUM(is_wicket) AS wickets
FROM odi_deliveries
GROUP BY bowler
ORDER BY wickets DESC
LIMIT 10;

-- 10. Best Economy (Min 300 Balls)
SELECT bowler,
       COUNT(*) AS balls,
       SUM(total_runs) AS runs_conceded,
       ROUND(SUM(total_runs)*6.0/COUNT(*),2) AS economy
FROM odi_deliveries
GROUP BY bowler
HAVING balls >= 300
ORDER BY economy ASC
LIMIT 10;

-- 11. Bowling Average (Min 50 Wickets)
SELECT bowler,
       SUM(total_runs) AS runs_conceded,
       SUM(is_wicket) AS wickets,
       ROUND(SUM(total_runs)*1.0/SUM(is_wicket),2) AS avg
FROM odi_deliveries
GROUP BY bowler
HAVING wickets >= 50
ORDER BY avg ASC
LIMIT 10;

-- 12. Highest Team Score in an Innings
SELECT match_id, innings AS team,
       SUM(total_runs) AS total_score
FROM odi_deliveries
GROUP BY match_id, innings
ORDER BY total_score DESC
LIMIT 10;

-- 13. Lowest Team Score
SELECT match_id, innings AS team,
       SUM(total_runs) AS total_score
FROM odi_deliveries
GROUP BY match_id, innings
ORDER BY total_score ASC
LIMIT 10;

-- 14. Team-wise Total Runs
SELECT innings AS team,
       SUM(total_runs) AS total_runs
FROM odi_deliveries
GROUP BY innings
ORDER BY total_runs DESC;

-- 15. Dot Ball % (Min 300 Balls)
SELECT bowler,
       COUNT(*) AS balls,
       SUM(CASE WHEN total_runs = 0 THEN 1 ELSE 0 END) AS dot_balls,
       ROUND(SUM(CASE WHEN total_runs = 0 THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS dot_ball_pct
FROM odi_deliveries
GROUP BY bowler
HAVING balls >= 300
ORDER BY dot_ball_pct DESC
LIMIT 10;

-- 16. Boundary %
SELECT batter,
       COUNT(*) AS balls,
       SUM(CASE WHEN runs_batter IN (4,6) THEN 1 ELSE 0 END) AS boundaries,
       ROUND(SUM(CASE WHEN runs_batter IN (4,6) THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS boundary_pct
FROM odi_deliveries
GROUP BY batter
HAVING balls >= 300
ORDER BY boundary_pct DESC
LIMIT 10;

-- 17. Over-wise Average Runs
SELECT over,
       ROUND(AVG(over_runs),2) AS avg_runs
FROM (
    SELECT match_id, innings, over,
           SUM(total_runs) AS over_runs
    FROM odi_deliveries
    GROUP BY match_id, innings, over
)
GROUP BY over
ORDER BY over;

-- 18. Head-to-Head Batter vs Bowler
SELECT batter, bowler,
       COUNT(*) AS balls,
       SUM(runs_batter) AS runs,
       SUM(is_wicket) AS wickets
FROM odi_deliveries
GROUP BY batter, bowler
HAVING balls >= 50
ORDER BY runs DESC
LIMIT 20;

-- 19. Matches Played by Each Team
SELECT team1, COUNT(*) AS matches
FROM odi_matches
GROUP BY team1
ORDER BY matches DESC;

-- 20. Unique Players Count
SELECT COUNT(DISTINCT batter) AS unique_batters
FROM odi_deliveries;