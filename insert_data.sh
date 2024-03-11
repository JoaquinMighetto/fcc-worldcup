#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
  RESULT_TRUNCATE=$($PSQL "TRUNCATE games, teams")
  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    if [[ $YEAR != "year" ]]
      then
        #get team_id
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        #if not found
        if [[ -z $WINNER_ID ]]
          then
            #insert team
            RESULT_INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
            #get winner team_id
            WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
          fi

        #get team_id from opponent
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        #if not found
        if [[ -z $OPPONENT_ID ]]
          then
            #insert team
            RESULT_INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
            #get opponent team_id
            OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
          fi


        #get game_id
        GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year=$YEAR AND round='$ROUND' AND winner_id='$WINNER_ID'")
        #if not found
        if [[ -z $GAME_ID ]]
          then
            #insert game
            INSERT_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, winner_goals, opponent_id, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $WINNER_GOALS, $OPPONENT_ID, $OPPONENT_GOALS)")
          fi
      fi
  done
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
  RESULT_TRUNCATE=$($PSQL "TRUNCATE games, teams")
  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    if [[ $YEAR != "year" ]]
      then
        #get team_id
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        #if not found
        if [[ -z $WINNER_ID ]]
          then
            #insert team
            RESULT_INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
            #get winner team_id
            WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
          fi

        #get team_id from opponent
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        #if not found
        if [[ -z $OPPONENT_ID ]]
          then
            #insert team
            RESULT_INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
            #get opponent team_id
            OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
          fi


        #get game_id
        GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year=$YEAR AND round='$ROUND' AND winner_id=$WINNER_ID")
        #if not found
        if [[ -z $GAME_ID ]]
          then
            #insert game
            INSERT_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, winner_goals, opponent_id, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $WINNER_GOALS, $OPPONENT_ID, $OPPONENT_GOALS)")
          fi
      fi
  done
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
