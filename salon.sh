#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"
#PRINT TITLE AND NAME OF SALON

TRUNCATE=$($PSQL "TRUNCATE customers, appointments")
echo -e "\n Welcome to Mojito Salon. How can we help you today?"


# menu function will display all of the services

MAIN_MENU (){
  # echo parameters if function is called with one. helps to display messages if incorrect service is selected
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  #get service id and names from services tables
  SERVICES=$($PSQL  "SELECT * FROM services")
  
  #display services and id's
  echo "$SERVICES" | while read ID BAR NAME
  do 
      echo -e "\n$ID) $NAME"

  done

  #read 
  read SERVICE_ID_SELECTED
  SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELCTED'")
  case $SERVICE in
    1) SERVICES $SERVICE_SELECTED;;
    2) SERVICES $SERVICE_SELECTED;;
    3) SERVICES $SERVICE_SELECTED;;
    4) SERVICES $SERVICE_SELECTED;;
    *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac

}

SERVICES() {
  SERVICE_SELECTED=$1
  SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE name = '$SERVICE_SELECTED'")

  echo -e "\nPlease answer all of the questions below to schedule your appointment:\n"

  #ask for phone number 
  echo -e "What's your phone number? (Ex. 555-555-5555)"
  read PHONE_NUMBER

  # check if number is in the correct format 
  case "$PHONE_NUMBER" in
  [1-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]) ;;
  *) SERVICES "Please add a correct phone number:";;
  esac

  # get customer name using phone number 
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$PHONE_NUMBER'")
  
  #if number not in database
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get customer name 
    echo -e "\nThere is not a record with that phone number, what's your name?"
    read NAME
    # add new to customers table 
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$NAME', '$PHONE_NUMBER')")
  fi
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$PHONE_NUMBER'")
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$PHONE_NUMBER'")
  

  #ask about time for appointment 
  echo -e "\nWhat time would you like you $SERVICE_SELECTED,$CUSTOMER_NAME?"
  read TIME


  #add apointment 
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$TIME')")
  echo -e "\nI have put you down for a $SERVICE_SELECT at $TIME, $CUSTOMER_NAME\n"

  MAIN_MENU "Welcome to Mojito Salon. How can we help you today?"




  
}






MAIN_MENU
