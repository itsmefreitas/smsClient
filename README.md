# smsClient
A C language and shell scripting mini chat client/server model demonstrating the use of named pipes in Linux systems for interprocess communication.

## Usage

- Compile the binary executable files handling the communication between named pipes (FIFOS) as follows:

```
gcc -o server server.c
gcc -o client client.c
```

- Assign execution permissions to the shell scripts you’ll be running to use the
program, which are listed in the same directory and named: SMSClient.sh and
SMSServer.sh:

```
chmod +x SMSServer.sh
chmod +x SMSClient.sh
```

- Creation of new users on the system is performed by running the command:
```
./SMSServer.sh adduser [username]
```

(where [username] is the desired username you’ll assign to the new user being created)

- Initialize the server with:
```
./SMSServer
```

- Login to a user (on another bash window):
```
./SMSClient [username]
```

- Remove a user from the system with:
```
./SMSServer.sh rmuser [username]
```
