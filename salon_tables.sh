#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -c"

#drop tables 

DROP_TABLES=$($PSQL "DROP TABLE customers, services, appointments")

# creates customers table

CREATE_CUSTOMERS=$($PSQL "CREATE TABLE customers(customer_id SERIAL PRIMARY KEY, name VARCHAR(15) NOT NULL, phone VARCHAR(12) UNIQUE NOT NULL)")
if [[ $CREATE_CUSTOMERS = "CREATE TABLE" ]]
then
  echo "Customers table has been created"
fi

#creates services table

CREATE_SERVICES=$($PSQL "CREATE TABLE services(service_id SERIAL PRIMARY KEY, name VARCHAR(20))")
if [[ $CREATE_CUSTOMERS = "CREATE TABLE" ]]
then
  echo "Services table has been created"
fi

ADD_SERVICES=$($PSQL "INSERT INTO services(name) VALUES ('cut'), ('color'), ('perm'), ('style')")

# create appointments table 

CREATE_APPOINTMENTS=$($PSQL "CREATE TABLE appointments(appointment_id SERIAL PRIMARY KEY, customer_id INT NOT NULL, service_id INT NOT NULL, time VARCHAR(10), FOREIGN KEY (customer_id) REFERENCES customers(customer_id), FOREIGN KEY (service_id) REFERENCES services(service_id))")
if [[ $CREATE_CUSTOMERS = "CREATE TABLE" ]]
then
  echo "Appointments table has been created"
fi

