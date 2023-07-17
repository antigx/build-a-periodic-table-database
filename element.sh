#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t   -c"

if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]*$ ]]
  then
    echo "$($PSQL "select e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius from elements as e inner join properties as p using(atomic_number) inner join types as t using(type_id) where atomic_number=$1 OR symbol='$1' or name='$1'")" | while read NAME BAR SYMBOL BAR TYPE BAR MASS BAR MELT BAR BOIL
    do
      echo "The element with atomic number $ATOMIC is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  fi 
fi