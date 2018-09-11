all: server client

server: server.c
	gcc -o server server.c
	chmod +x SMSServer.sh

client: client.c
	gcc -o client client.c
	chmod +x SMSClient.sh

clean:
	rm -f ./server
	rm -f ./client
