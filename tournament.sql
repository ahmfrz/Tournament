-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

create table players(
    player_id serial primary key,
    name text);

create table match_result(
    id serial primary key,
    winner integer references players(player_id),
    loser integer references players(player_id)
    );

create view standings as SELECT players.player_id AS ID, players.name AS NAME, WINS, MATCHES
    FROM players LEFT JOIN (
    (SELECT players.player_id AS id, count(id) AS matches FROM players LEFT JOIN match_result
    ON players.player_id = match_result.winner or players.player_id = match_result.loser group by
    players.player_id) AS player
    LEFT JOIN (SELECT player_id AS id,count(winner) AS wins FROM players LEFT JOIN match_result ON player_id = winner
    GROUP BY player_id) AS won_matches
    ON player.id = won_matches.id) ON players.player_id = player.id
    ORDER BY wins DESC;

