#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN_MENU() {
if [[ -z $1 ]] 
then
  echo "Please provide an element as an argument."
else

  if [[ $1 =~ ^-?[0-9]+$ ]]
  then 
    ELEMENT_RESULT=$($PSQL "select atomic_number from elements where atomic_number=$1;")
    if [[ $ELEMENT_RESULT ]]
    then 
      PRINT_DETAILS $ELEMENT_RESULT
    else
      echo "I could not find that element in the database."
    fi
  else
    ELEMENT_RESULT=$($PSQL "select atomic_number from elements where symbol='$1' OR name='$1';")
    if [[ $ELEMENT_RESULT ]]
    then
      PRINT_DETAILS $ELEMENT_RESULT
    else 
      echo "I could not find that element in the database."
    fi
  fi
fi
}

PRINT_DETAILS() {
  if [[ $1 ]] 
  then
    ATOMIC_NUMBER=$1
    ATOMIC_NAME=$($PSQL "Select name from elements where atomic_number=$ATOMIC_NUMBER;")
    ATOMIC_SYMBOL=$($PSQL "Select symbol from elements where atomic_number=$ATOMIC_NUMBER;")

    ELEMENT_TYPE_ID=$($PSQL "Select type_id from properties where atomic_number=$ATOMIC_NUMBER;")
    ELEMENT_TYPE=$($PSQL "Select type from types where type_id=$ELEMENT_TYPE_ID;")
    ELEMENT_ATOMIC_MASS=$($PSQL "Select atomic_mass from properties where atomic_number=$ATOMIC_NUMBER;")
    ELEMENT_MELTING_POINT=$($PSQL "Select melting_point_celsius from properties where atomic_number=$ATOMIC_NUMBER;")
    ELEMENT_BOILING_POINT=$($PSQL "Select boiling_point_celsius from properties where atomic_number=$ATOMIC_NUMBER;")

    echo "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ATOMIC_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
  fi
}

MAIN_MENU $1