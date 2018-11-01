#include <sys/socket.h>
#include <sys/types.h>
#include <linux/if_ether.h>
#include <netpacket/packet.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX 65536

int main(int argc, char *argv[]){
    int sock, length, count, index;
    char buffer[MAX];
  	struct sockaddr_ll addr;
  	ssize_t size;
  	struct iphdr *ip;
  	char *addrString;
  	register char mf;
  	register short int offset;
  	fd_set mySet;
   
  	if (argc == 3){
       sscanf(argv[2],"%d", &index);
       sscanf(argv[1], "%d", &count);
  	}

  	if (argc == 2){
   	   sscanf(argv[1],"%d", &count);
  	}
   
   //vytvoreni socketu
  	if((sock = socket(PF_PACKET, SOCK_DGRAM, htons(ETH_P_IP))) == -1){
    	perror("Selhal socket");
    	return -1;
  	}

   //prijem dat
  	for (int i = 0; i < count; i++){
    	FD_ZERO(&mySet);
    	FD_SET(sock, &mySet);
    	if (select(sock + 1, &mySet, NULL, NULL, NULL) == -1){
      		perror("Selhal select");
      		close(sock);
      		return -1;
    	}
    	size = sizeof(addr);
    	if ((length = recvfrom(sock, buffer, MAX, 0,
	  	(struct sockaddr *)&addr,(socklen_t *)&size)) == -1){
      	perror("selhal recvfrom");
      	close(sock);
      	return -1;     
    }
  
  //vypis dat
    	if (index && index == addr.sll_ifindex){
      		printf("----------------------------------------------\n");
      		printf("Prijato: %d bytu\n", length);
      		printf("Protokol (linkovy): %d\n", addr.sll_protocol);
      		printf("Index sitoveho rozhrani: %d\n", addr.sll_ifindex);  
      		printf("Velikost (linkove)  adresy odesilatele: %d\n", addr.sll_halen);

      		if (addr.sll_halen != 0){
	    		printf("Adresa (linkova) odesilatele: ");
      			for (int i = 0; i < addr.sll_halen - 1; i++){
	     			 printf("%x:", addr.sll_addr[i]);
      			}
      			printf("%x\n", addr.sll_addr[addr.sll_halen - 1]);
     		}
     		break;	   
    	}

    	else if (index && index != addr.sll_infindex){
    		printf("Zadany ramec nenalezen.");
    	}

    	else{
      		printf("----------------------------------------------\n");
      		printf("Prijato: %d bytu\n", length);
      		printf("Protokol (linkovy): %d\n", addr.sll_protocol);
      		printf("Index sitoveho rozhrani: %d\n", addr.sll_ifindex);  
      		printf("Velikost (linkove)  adresy odesilatele: %d\n", addr.sll_halen);

      		if (addr.sll_halen != 0){
	      		printf("Adresa (linkova) odesilatele: ");
        		for (int i = 0; i < addr.sll_halen - 1; i++){
	      			printf("%x:", addr.sll_addr[i]);
        		}
      		printf("%x\n", addr.sll_addr[addr.sll_halen - 1]);
      		}
    	}      
  	}  
}
