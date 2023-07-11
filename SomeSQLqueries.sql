USE master_foot;

/* See the content of each table*/
SELECT * FROM continents;
SELECT * FROM countries;
SELECT * FROM players;
SELECT * FROM player_statistics;
SELECT * FROM teams;
SELECT * FROM team_statistics;
SELECT * FROM cities;
SELECT * FROM managers;
SELECT * FROM referees;

/* This query retrieves the names of teams along with the average goals scored by each team.
It calculates the average goals for each team using the team_statistics table. */
SELECT teams.name, AVG(team_statistics.goals_for) AS avg_goals
FROM teams
JOIN team_statistics ON teams.id = team_statistics.team_id
GROUP BY teams.id
ORDER BY avg_goals DESC
LIMIT 5;

/* This query retrieves the first name, last name, and goals scored by players who have scored more than one goal.
 It retrieves this information from the players and player_statistics tables. */
SELECT players.first_name, players.last_name, player_statistics.goals
FROM players
JOIN player_statistics ON players.id = player_statistics.player_id
WHERE player_statistics.goals > 1;

/*This query retrieves the names of teams along with the count of male players in each team. 
It counts the number of male players in each team using the players table.*/
SELECT teams.name, COUNT(players.id) AS male_player_count
FROM teams
JOIN players ON teams.id = players.team_id
WHERE players.is_male = true
GROUP BY teams.id
ORDER BY male_player_count DESC;

/* This query retrieves the names of teams and their respective stadiums in the city of Berlin,
 providing information about the team-stadium relationship in that specific location.*/
SELECT teams.name AS team_name, stadiums.name AS stadium_name
FROM teams
JOIN stadiums ON teams.id = stadiums.team_id
JOIN cities ON teams.city_id = cities.id
WHERE cities.name = 'Berlin';

/* This query retrieves the first name, last name, and goals scored by players
 who have surpassed the average goals of their respective teams, providing insights 
into the performance of individual players relative to their teams' scoring averages.*/
SELECT players.first_name, players.last_name, player_statistics.goals
FROM players
JOIN player_statistics ON players.id = player_statistics.player_id
JOIN teams ON players.team_id = teams.id
JOIN (
    SELECT team_id, AVG(goals_for) AS avg_goals
    FROM team_statistics
    GROUP BY team_id
) AS team_avg ON players.team_id = team_avg.team_id
WHERE player_statistics.goals > team_avg.avg_goals;











