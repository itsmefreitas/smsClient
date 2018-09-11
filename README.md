# smsClient
A C language and shell scripting mini chat client/server model demonstrating the use of named pipes in Linux systems for interprocess communication.

## Usage

- Compile the project with:
```
make all
```

- Creation of new users on the system is performed by running the command:
```
./SMSServer.sh adduser [username]
```

(where [username] is the desired username you’ll assign to the new user being created)

- Initialize the server:
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
