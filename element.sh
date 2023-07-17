#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t  --no-align -c"

if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]*$ ]]
  then
    WHERE="where atomic_number=$1"
  else
      WHERE="WHERE symbol='$1' or name='$1'"
  fi
  RESULT="$($PSQL "select e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius from elements as e inner join properties as p using(atomic_number) inner join types as t using(type_id) $WHERE")"
  IFS="|" read ATOMIC NAME SYMBOL TYPE MASS MELT BOIL <<< $RESULT
  echo "The element with atomic number $ATOMIC is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
fi