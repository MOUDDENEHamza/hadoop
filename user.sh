#!/bin/bash

# Print greeting message
echo "HADOOP"
echo
echo "Hello $HOSTNAME, if it is the first time you run this application, please mind that before you launch this script"
echo "you should write a file in the servers you will use."
echo $'\e[33;1mTips :\e[0m\eT To generate a text file you can use generate_data.sh script in data folder before you '
echo "run the application."

# Propose a menu allowing user execute different options
while true; do
  # print Usage and get a choice from user
  echo
  echo "To exit please type 0"
  echo "To write a text file to servers type 1"
  echo "To list the content of servers type 2"
  echo "To delete file from servers type 3"
  echo "To run the application please type 4"
  echo
  printf "Please type your choice : "
  read choice

  # Handle the input if it is an integer
  if [[ $choice ]] && [ "$choice" -eq "$choice" ] 2>/dev/null; then
    # To generate text file and write it on servers
    if [[ $choice -eq 1 ]]; then
      cd data
      ./generate_data.sh
      cd ..
      java -cp src:lib/snakeyaml-1.5.jar hdfs.HdfsClient write line data/data.txt 147.127.135.160
    # List servers data
    elif [[ $choice -eq 2 ]]; then
      java -cp src:lib/snakeyaml-1.5.jar hdfs.HdfsClient list 147.127.135.160
    # Delete file from servers
    elif [[ $choice -eq 3 ]]; then
      java -cp src:lib/snakeyaml-1.5.jar hdfs.HdfsClient delete data/data.txt 147.127.135.160
    elif [[ $choice -eq 4 ]]; then
      sleep 5
      java -cp src application.MyMapReduce data/data.txt
    # Exit the script
    elif [[ $choice -eq 0 ]]; then
      echo
      echo "Goodbye"
      break
    # if the choice is greater than 2 or lower than 0
    else
      echo $'\e[31;1mERROR :\e[0m\eT Wrong input, please type an integer between 0 and 4.'
      echo "Please try again"
    fi
  # Handle the input if it is not an integer
  else
    echo $'\e[31;1mERROR :\e[0m\eT '"$choice"' is not an integer or not defined'
    echo "Please try again"
  fi
done
echo
