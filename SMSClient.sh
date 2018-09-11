#!/bin/bash

# traptest.sh

PROCESS=$(pgrep -fl ./SMSServer.sh)

if [[ -z $PROCESS ]]; then

    clear
    echo "** SMSServer isn't running! **"
    echo "Initialize it before running SMSClient."
    echo "Press any key to continue..."
    read -rsn1 key
    exit

else

    if [[ ! -z $1 ]]; then

        printf "Password? "

        read -s PASSWORD

        USER=$(grep -w "$1"::"$PASSWORD" .userdata.txt)

        if [[ ! -z $USER ]]; then

            ISONLINE=$(grep -w "$1" .online)

            ./client "syslog" "@$1 just signed in."
            ./server "$1"&

            trap 'handler1 $1' SIGTERM SIGINT SIGKILL

            handler1 () {

                clear
                rm $1
                echo "** Server has been terminated, system will now shut down! **"
                echo "** Logging out... Thanks for using SMSClient! **"
                sleep 3
                clear
                exit

            }

            if [[ -z $ISONLINE ]]; then
                echo $1 >> .online
            fi


            while [ true ];
            do
            
            clear
            echo "** Welcome $1! You may now use SMSCLient. **"
            echo ""
            echo "1) List online users"
            echo "2) Send SMS to a user"
            echo "3) Logout SMSClient"
            echo ""

            read -n1 OP

            if [[ $OP == 1 ]]; then

                clear
                echo "Currently online users: "
                cat .online
                echo ""
                sleep 0.5
                echo "** Press any key to continue **"
                read -rsn1 key

            fi

            if [[ $OP == 2 ]]; then

                clear
                printf "@handler: "
                read HANDLER
                printf "Your message: "
                read MSG

                if [[ $HANDLER != $1 && ! -z $HANDLER && ! -z $MSG ]]; then

                    ISONLINE=$(grep -w "$HANDLER" .online)

                    if [[ ! -z $ISONLINE ]]; then

                        ./client "$HANDLER" "@$1 said: $MSG"
                        ./client "syslog" "-> @$1 messaged @$HANDLER."

                    else

                        clear
                        echo "The user isn't online or doesn't exist."

                    fi
                else
                
                    clear
                
                    if [[ -z $HANDLER || -z $MSG ]]; then
                        
                        echo "You need to specify both a user and a message to send!"
                    
                    fi
                    
                    if [[ $HANDLER = $1 ]]; then
                    
                        echo "** Why would you message yourself, silly?! **"
                        
                    fi

                fi

                sleep 0.5
                echo "** Press any key to continue **"
                read -rsn1 key

            fi

            if [[ $OP == 3 ]]; then
                clear
                ./client "syslog" "@$1 signed out."
                sed -i -e '/'$1'/d' .online
                rm $1
                #rm .online-e
                echo "** Logging out... Thanks for using SMSClient! **"
                sleep 2
                clear
                exit
            fi

            done

        else echo "Invalid user or password match..."

        fi

    else

        echo "No user specified! Usage: SMSClient <username>"

    fi

fi
