-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

/* Drop the database for a clean start */
DROP DATABASE IF EXISTS tournament;

/* Create tournament database and connect to it */
CREATE DATABASE tournament;
\c tournament;


/* Create tournament table */
CREATE TABLE tournaments(
        id SERIAL PRIMARY KEY
    );


/* Create players table */
CREATE TABLE players(
        player_id SERIAL PRIMARY KEY,
        name TEXT,
        t_id INTEGER REFERENCES tournaments
    );


/* Create match results table */
CREATE TABLE match_results(
        id SERIAL PRIMARY KEY,
        winner INTEGER REFERENCES players(player_id),
        loser INTEGER REFERENCES players(player_id),
        t_id INTEGER REFERENCES tournaments
    );


/* Select number of matches played by individual player in each tournament */
CREATE VIEW player AS
    SELECT players.player_id AS id, count(id) AS matches, players.t_id AS player_t_id
    FROM players LEFT JOIN match_results
    ON players.player_id = match_results.winner OR players.player_id = match_results.loser
    GROUP BY players.player_id, players.t_id
    ORDER BY players.t_id;


/* Select number of matches won by individual player in each tournament */
CREATE VIEW won_matches AS
    SELECT player_id AS id, count(winner) AS wins, players.t_id as wins_t_id
    FROM players LEFT JOIN match_results
    ON player_id = winner and players.t_id = match_results.t_id
    GROUP BY player_id, players.t_id
    ORDER BY players.t_id;


/* Get player standings */
CREATE VIEW standings AS
    SELECT players.player_id AS ID, players.name AS NAME, WINS, MATCHES, players.t_id as TOURNAMENT
    FROM players LEFT JOIN (
    player LEFT JOIN won_matches ON player.id = won_matches.id and player_t_id = wins_t_id)
    ON players.player_id = player.id
    ORDER BY TOURNAMENT, WINS DESC;
