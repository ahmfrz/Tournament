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

/* Create players table */
CREATE TABLE players(
        player_id SERIAL PRIMARY KEY,
        name TEXT
    );

/* Create match results table */
CREATE TABLE match_results(
        id SERIAL PRIMARY KEY,
        winner INTEGER REFERENCES players(player_id),
        loser INTEGER REFERENCES players(player_id)
    );

/* Select number of matches played by individual player */
CREATE VIEW player AS
    SELECT players.player_id AS id, count(id) AS matches
    FROM players LEFT JOIN match_results
    ON players.player_id = match_results.winner OR players.player_id = match_results.loser
    GROUP BY players.player_id;

/* Select number of matches won by individual player */
CREATE VIEW won_matches AS
    SELECT player_id AS id, count(winner) AS wins
    FROM players LEFT JOIN match_results
    ON player_id = winner
    GROUP BY player_id;

/* Get player standings */
CREATE VIEW standings AS
    SELECT players.player_id AS ID, players.name AS NAME, WINS, MATCHES
    FROM players LEFT JOIN (
    player LEFT JOIN won_matches ON player.id = won_matches.id)
    ON players.player_id = player.id
    ORDER BY WINS DESC;