#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t  --no-align -c"

#check if no argument
if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
else
  #check if number
  if [[ $1 =~ ^[0-9]*$ ]]
  then
    WHERE="where atomic_number=$1"
  #if string
  else
      WHERE="WHERE symbol='$1' or name='$1'"
  fi
  
  #query db
  RESULT="$($PSQL "select e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius from elements as e inner join properties as p using(atomic_number) inner join types as t using(type_id) $WHERE")"
  #check if any result
  if [[ -z $RESULT ]]
  then
    echo "I could not find that element in the database."
  #echo output if found
  else
    IFS="|" read ATOMIC NAME SYMBOL TYPE MASS MELT BOIL <<< $RESULT
    echo "The element with atomic number $ATOMIC is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
  fi
fi