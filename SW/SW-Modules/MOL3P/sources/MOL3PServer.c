/* ********************************************** */
/* *** My Own Layer 3 Protocol server ( C++ ) *** */
/* ********************************************** */

// ******************
// **** INCLUDES ****
// ******************
#include "MOL3PServer.h"


/* ***************** */
/* *** FUNCTIONS *** */
/* ***************** */

void error(const char *msg)
{
    perror(msg);
    exit(1);
}

/* ************ */
/* *** MAIN *** */
/* ************ */

int main(int argc, char *argv[])
{

    // -------------------
    // --- Definitions ---
    // -------------------

    // Definitions
     int sockfd, newsockfd, portno;
     socklen_t clilen;
     char buffer[256];
     struct sockaddr_in serv_addr, cli_addr;
     int n;

    // Sockets
    int sockfd_ToMotionControl;

     // Create the socket
     sockfd = socket(AF_INET, SOCK_STREAM, 0);
     if (sockfd < 0) 
        error("ERROR opening socket");
     bzero((char *) &serv_addr, sizeof(serv_addr));
     portno = PORT_MOL3P;
     serv_addr.sin_family = AF_INET;
     serv_addr.sin_addr.s_addr = INADDR_ANY;
     serv_addr.sin_port = htons(portno);
     // Bind socket
     if (bind(sockfd, (struct sockaddr *) &serv_addr,
              sizeof(serv_addr)) < 0) 
              error("ERROR on binding");
     listen(sockfd,5);
     clilen = sizeof(cli_addr);

     std::cout << "MOL3P: Server OK." << std::endl;

     // Main loop of acceptance
     while(1)
     {
	 printf("SERVER: accepting\n");
	 newsockfd = accept(sockfd, 
			    (struct sockaddr *) &cli_addr, 
			    &clilen);
	 printf("SERVER: accepted\n");
	 if (newsockfd < 0) 
	     error("ERROR on accept");
	 bzero(buffer,256);
	 n = read(newsockfd,buffer,255);
	 if (n < 0) error("ERROR reading from socket");
	 printf("SERVER: Here is the message: %s\n",buffer);
	 close(newsockfd);

	 // Once received, we extract the data
	 // Syntax:
	 // M-LXX-RYY where XX is the speed of the left motor and YY the speed of the right motor
	 std::string Command(buffer);
	 std::cout << "COMMAND : " << Command << std::endl;
	 std::size_t LPOS = Command.find("L");
	 std::size_t RPOS = Command.find("R");
	 std::string LVAL = Command.substr(LPOS+1, RPOS-2);
	 std::string RVAL = Command.substr(RPOS+1);
	 std::cout << "\rL : " << LVAL << std::endl;
	 std::cout << "\rR : " << RVAL << std::endl;

	 char * Left_hex = new char [LVAL.length()+1];;
	 char * Right_hex = new char [LVAL.length()+1];;
	 
	 strcpy(Left_hex,LVAL.c_str());
	 strcpy(Right_hex,RVAL.c_str());

	 // Now send this to Motion control

//	 MotionControlTypes::t_Transaction v_Transaction(Left_hex,Right_hex);
//	 v_Transaction.serialize();

//	 sockfd_ToMotionControl = ITC::ITC_connect_to_server(PORT_MOTIONCONTROL);
//	 ITC::ITC_write(sockfd_ToMotionControl,v_Transaction.v_Serialized,4);
//	 sockfd_ToMotionControl = ITC::close_client(sockfd_ToMotionControl);

     }

     close(sockfd);
     return 0; 
     
}
