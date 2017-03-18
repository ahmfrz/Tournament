#!/usr/bin/env python
#
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2
import bleach


def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")


def addTournament(tour_id):
    """Adds a tournament to the tournament database."""
    connection = connect()
    cursor = connection.cursor()
    query = "INSERT INTO tournament VALUES(%s)"
    cursor.execute(query, (tour_id,))
    connection.commit()
    connection.close()


def deleteTournaments():
    """Remove all tournament records from database."""
    connection = connect()
    cursor = connection.cursor()
    query = "DELETE FROM tournament"
    cursor.execute(query)
    connection.commit()
    connection.close()


def deleteMatches():
    """Remove all the match records from the database."""
    connection = connect()
    cursor = connection.cursor()
    query = "DELETE FROM match_results"
    cursor.execute(query)
    connection.commit()
    connection.close()


def deletePlayers():
    """Remove all the player records from the database."""
    connection = connect()
    cursor = connection.cursor()
    query = "DELETE FROM players"
    cursor.execute(query)
    connection.commit()
    connection.close()


def countPlayers():
    """Returns the number of players currently registered."""
    connection = connect()
    cursor = connection.cursor()
    query = "SELECT COUNT(player_id) FROM players GROUP BY player_id, t_id"
    cursor.execute(query)
    connection.commit()
    count = cursor.fetchall()
    connection.close()
    return len(count)


def registerPlayer(name, tour_id):
    """Adds a player to the tournament database.

    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)

    Args:
      name: the player's full name (need not be unique).
    """
    connection = connect()
    query = "INSERT INTO players(name, t_id) VALUES(%s, %s)"
    cursor = connection.cursor()
    cursor.execute(query, (bleach.clean(name), bleach.clean(tour_id)))
    connection.commit()
    connection.close()


def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    connection = connect()
    query = "SELECT * FROM standings"
    cursor = connection.cursor()
    cursor.execute(query)
    result = cursor.fetchall()
    connection.close()
    return result


def reportMatch(winner, loser, tour_id):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """
    connection = connect()
    cursor = connection.cursor()
    query = "INSERT INTO match_results(winner, loser, t_id) VALUES(%s, %s, %s)"
    cursor.execute(
        query,
        (bleach.clean(winner),
         bleach.clean(loser),
         bleach.clean(tour_id)))
    connection.commit()
    connection.close()


def swissPairings():
    """Returns a list of pairs of players for the next round of a match.

    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.

    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """
    standings = playerStandings()
    list_of_pairs = []
    for player in range(len(standings)/2):
        pairs = (standings[player * 2][0],
                 standings[player * 2][1],
                 standings[player * 2][4],
                 standings[player * 2 + 1][0],
                 standings[player * 2 + 1][1],
                 standings[player * 2 + 1][4])
        list_of_pairs.append(pairs)
    return list_of_pairs
