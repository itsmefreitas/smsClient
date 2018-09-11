#!/bin/bash

clear

PROCESS=$(pgrep -flc ./SMSServer.sh)

if [[ $PROCESS = "1" ]]; then
    
if [[ $1 == "adduser" && ! -z $2 ]]; then

    echo "Password? "
    read password
    echo "Password Confirm? "
    read passwordconfirm
    
    while [[ $password != $passwordconfirm ]]; do
        clear
        echo "SMSServer adduser $2"
        echo "Password? "
        read password
        echo "Password Confirm? "
        read passwordconfirm  
    done
    
    if [[ ! -f ".userdata.txt" ]]; then
    
        touch .userdata.txt
    
    fi
    
    USREXISTS=$(grep "$2" .userdata.txt)
    
    if [[ -z "$USREXISTS" ]]; then
    
      echo "$2::$password" >> .userdata.txt
      echo "" >> .userdata.txt  
    
    else
        echo "User already exists!!"
    
    fi
    
elif [[ $1 == "rmuser" && ! -z $2 ]]; then

    echo "Password? "
    read password
    echo "Password Confirm? "
    read passwordconfirm
    
    while [[ $password != $passwordconfirm ]]; do
        clear
        echo "SMSServer adduser $2"
        echo "Password? "
        read password
        echo "Password Confirm? "
        read passwordconfirm  
    done
    
    if [[ ! -f ".userdata.txt" ]]; then
    
        touch .userdata.txt
    
    fi
    
    USREXISTS=$(grep "$2" .userdata.txt)
    
    if [[ ! -z "$USREXISTS" ]]; then
    
       #user removal process
       RMUSR="$2::$password"
       sed -i -e '/'$RMUSR'/d' .userdata.txt
    
    else
        echo "User doesn't exist!"
    
    fi

elif [[ $# = 0 ]]; then

    echo "Server online."
    echo "Waiting for new messages.."
    
    if [[ -p "syslog" ]]; then
        rm syslog
    fi
    
    ./server "syslog"&
    
    if [[ ! -f ".online" ]]; then
        touch .online
    fi
    
    while [ true ];
    do
    
    read -rsn1 key

    if [[ $key = q || $key = Q ]]; then
        
        clear
        
        #TODO: figure what the fuck is happening with my code.
        
        NUSERS=$(pgrep -flc ./SMSClient.sh)
        
        clear
            
        echo "There are $NUSERS user(s) logged in right now."
        echo "Are you sure you want to terminate SMSServer (Y/N)?"

	while [[ true ]];
	do
	
            read -rsn1 OPTION
	    
            if [[ $OPTION = y || $OPTION = Y ]]; then

		rm syslog

		clear
		echo "** System will be terminated in 3 seconds! **"
		echo "Logging off all users..."
		sleep 3

		pkill -f SMSClient.sh
		
		rm .online
        
        clear

		exit
		
            fi

	    if [[ $OPTION = n || $OPTION = N ]]; then

		clear
		echo "Server online."
		echo "Waiting for new messages.."
		break
		
	    fi
	    
	done
        
    fi
    
    done
    
else

    clear
    echo "Usage: SMSClient with no arguments for normal server mode."
    echo "Usage: SMSClient adduser <username> to add new users."
    echo "Usage: SMSClient rmuser <username> to remove existing users."
    echo ""
    echo "** Press any key to continue **"
    read -rsn1 bye
    clear
    exit

fi

else
    
    clear
    echo "SMSServer is already running!"
    echo ""
    echo "** Press any key to continue **"
    read -rsn1 bye
    clear
    exit

fi
