#Time mais punidos com cartões

SELECT * FROM banco.`2021-2022`;
SELECT HomeTeam, 
       SUM(HY) + SUM(AY) AS total_yellow_cards,  
       SUM(HR) + SUM(AR) AS total_red_cards 
FROM banco.`2021-2022` 
GROUP BY HomeTeam 
ORDER BY total_yellow_cards + total_red_cards DESC;

#Total de cartões amarelos e vermelhos por time da casa e time visitante:"

SELECT 
    HomeTeam,
    SUM(HY) AS total_home_yellow_cards,
    SUM(HR) AS total_home_red_cards
FROM 
    banco.`2021-2022`
GROUP BY 
    HomeTeam
ORDER BY 
    total_home_yellow_cards + total_home_red_cards DESC;

SELECT 
    AwayTeam,
    SUM(AY) AS total_away_yellow_cards,
    SUM(AR) AS total_away_red_cards
FROM 
    banco.`2021-2022`
GROUP BY 
    AwayTeam
ORDER BY 
    total_away_yellow_cards + total_away_red_cards DESC;

#Total de escanteios por time da Casa e time visitante:

SELECT 
    HomeTeam,
    SUM(HC) AS total_home_corners
FROM 
    banco.`2021-2022`
GROUP BY 
    HomeTeam
ORDER BY 
    total_home_corners DESC;

#Total de gols marcados e sofridos por Time:

SELECT 
    AwayTeam,
    SUM(AC) AS total_away_corners
FROM 
    banco.`2021-2022`
GROUP BY 
    AwayTeam
ORDER BY 
    total_away_corners DESC;

SELECT 
    HomeTeam,
    SUM(FTHG) AS total_home_goals_scored,
    SUM(FTAG) AS total_home_goals_conceded,
    SUM(FTHG) + SUM(FTAG) AS total_home_goals
FROM 
    banco.`2021-2022`
GROUP BY 
    HomeTeam
ORDER BY 
    total_home_goals DESC;
    
#Média de posse de bola por time em casa e fora:
 
SELECT 
    HomeTeam,
    AVG(HS) AS average_home_possession
FROM 
    banco.`2021-2022`
GROUP BY 
    HomeTeam
ORDER BY 
    average_home_possession DESC;

SELECT 
    AwayTeam,
    AVG(`AS`) AS average_away_possession
FROM 
    banco.`2021-2022`
GROUP BY 
    AwayTeam
ORDER BY 
    average_away_possession DESC;

#Percentual de aproveitamento de chutes à gol dentro de casa e fora:

SELECT 
    HomeTeam,
    SUM(HST) / SUM(HS) * 100 AS home_shooting_accuracy
FROM 
    banco.`2021-2022`
GROUP BY 
    HomeTeam
ORDER BY 
    home_shooting_accuracy DESC;

#Total de Vitórias, Empates e Derrotas por Time dentro de casa e fora:

SELECT 
    AwayTeam,
    SUM(AST) / SUM(`AS`) * 100 AS away_shooting_accuracy
FROM 
    banco.`2021-2022`
GROUP BY 
    AwayTeam
ORDER BY 
    away_shooting_accuracy DESC;

SELECT 
    HomeTeam,
    SUM(CASE WHEN FTR = 'H' THEN 1 ELSE 0 END) AS total_home_wins,
    SUM(CASE WHEN FTR = 'D' THEN 1 ELSE 0 END) AS total_home_draws,
    SUM(CASE WHEN FTR = 'A' THEN 1 ELSE 0 END) AS total_home_losses
FROM 
    banco.`2021-2022`
GROUP BY 
    HomeTeam;
    
SELECT 
    AwayTeam,
    SUM(CASE WHEN FTR = 'A' THEN 1 ELSE 0 END) AS total_away_wins,
    SUM(CASE WHEN FTR = 'D' THEN 1 ELSE 0 END) AS total_away_draws,
    SUM(CASE WHEN FTR = 'H' THEN 1 ELSE 0 END) AS total_away_losses
FROM 
    banco.`2021-2022`
GROUP BY 
    AwayTeam;

#Total de gols dentro de casa:

SELECT HomeTeam, SUM(FTHG) AS total_home_goals
FROM banco.`2021-2022`
GROUP BY HomeTeam
ORDER BY total_home_goals DESC;

#Total de gols marcados em cada intervalo de tempo (primeiro tempo e segundo tempo):

SELECT 
    SUM(HTHG) AS total_first_half_goals,
    SUM(FTHG - HTHG) AS total_second_half_goals
FROM 
    banco.`2021-2022`;
    
#Percentual de gols marcados em cada intervalo de tempo (primeiro tempo e segundo tempo):

SELECT 
    (SUM(HTHG) / (SUM(HTHG) + SUM(FTHG - HTHG))) * 100 AS first_half_goal_percentage,
    (SUM(FTHG - HTHG) / (SUM(HTHG) + SUM(FTHG - HTHG))) * 100 AS second_half_goal_percentage
FROM 
    banco.`2021-2022`;

#Média de gols marcados por rodada:

SELECT 
    ROUND(AVG(FTHG + FTAG), 2) AS average_goals_per_round
FROM 
    banco.`2021-2022`;

#Média de Gols Marcados por Dia da Semana:

SELECT 
    DAYNAME(Date) AS day_of_week,
    AVG(FTHG + FTAG) AS average_goals
FROM 
    banco.`2021-2022`
GROUP BY 
    day_of_week
ORDER BY 
    FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
    
#Número de Jogos por Mês:

SELECT 
    MONTH(Date) AS month,
    COUNT(*) AS total_games
FROM 
    banco.`2021-2022`
GROUP BY 
    month
ORDER BY 
    month;
  
#Número de Jogos por Hora do Dia:
  
SELECT 
    HOUR(Time) AS hour_of_day,
    COUNT(*) AS total_games
FROM 
    banco.`2021-2022`
GROUP BY 
    hour_of_day
ORDER BY 
    hour_of_day;

#Total de Jogos com Mais de 2,5 Gols:

SELECT 
    COUNT(*) AS total_over_2_5_goals
FROM 
    banco.`2021-2022`
WHERE 
    FTHG + FTAG > 2.5;

#Total de Jogos com Ambas as Equipes Marcando (BTTS):

SELECT 
    COUNT(*) AS total_btts
FROM 
    banco.`2021-2022`
WHERE 
    FTHG > 0 AND FTAG > 0;

#Resultado mais comum dos jogos (vitória, empate ou derrota):

SELECT 
    CASE 
        WHEN FTHG > FTAG THEN 'Home Win'
        WHEN FTHG = FTAG THEN 'Draw'
        ELSE 'Away Win'
    END AS result,
    COUNT(*) AS total_games
FROM 
    banco.`2021-2022`
GROUP BY 
    result
ORDER BY 
    total_games DESC;
 
#Percentual de chutes à gol convertidos em gols por time da casa:

SELECT 
    HomeTeam,
    SUM(HST) AS total_home_shots_on_target,
    SUM(FTHG) AS total_home_goals_scored,
    (SUM(FTHG) / SUM(HST)) * 100 AS home_shooting_accuracy
FROM 
    banco.`2021-2022`
GROUP BY 
    HomeTeam
ORDER BY 
    home_shooting_accuracy DESC;

#Percentual de chutes à gol convertidos em gols por time visitante:

SELECT 
    AwayTeam,
    SUM(AST) AS total_away_shots_on_target,
    SUM(FTAG) AS total_away_goals_scored,
    (SUM(FTAG) / SUM(AST)) * 100 AS away_shooting_accuracy
FROM 
    banco.`2021-2022`
GROUP BY 
    AwayTeam
ORDER BY 
    away_shooting_accuracy DESC;

#Média de chutes à gol por jogo:

SELECT 
    AVG(HS) AS average_home_shots,
    AVG(`AS`) AS average_away_shots
FROM 
    banco.`2021-2022`;
    
#Total de faltas cometidas por time da casa e time visitante:

SELECT 
    HomeTeam,
    SUM(HF) AS total_home_fouls
FROM 
    banco.`2021-2022`
GROUP BY 
    HomeTeam
ORDER BY 
    total_home_fouls DESC;
    
SELECT 
    AwayTeam,
    SUM(AF) AS total_away_fouls
FROM 
    banco.`2021-2022`
GROUP BY 
    AwayTeam
ORDER BY 
    total_away_fouls DESC;

#Média de faltas cometidas por jogo:"

SELECT 
    AVG(HF + AF) AS average_fouls_per_game
FROM 
    banco.`2021-2022`;


#Total de gols dentro de casa:

SELECT HomeTeam, SUM(FTHG) AS total_home_goals
FROM banco.`2021-2022`
GROUP BY HomeTeam
ORDER BY total_home_goals DESC;








