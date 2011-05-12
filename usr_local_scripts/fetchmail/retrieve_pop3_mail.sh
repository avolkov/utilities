#!/bin/bash 

####
# fetch all mail for accounts from a single server <pop3_ma in path_to_credentials_file specified in the following format
# username password
###
MAIL_SERVER=''

if [ $# != 1 ] || [ ! -f $1 ] 
then 
        echo "Usage: ./retrieve_pop3_mail.sh path_to_credentials_file" > /dev/stderr 
        exit 1 
fi 
credentials=$1 

OLD_IFS=$IFS 
IFS=' 
' 
for k in $(cat $credentials) 
do 
        username=$(echo $k | cut -f1 -d' ') 
        password=$(echo $k | cut -f2 -d' ') 
        echo "checking $username" 
        echo "set postmaster '$username' poll $MAIL_SERVER with proto POP3 options no dns user '$username' with password \"$password\" is '$username' here" | /usr/bin/fetchmail -f - 
done 

IFS=$OLD_IFS
