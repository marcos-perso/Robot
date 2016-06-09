/* ******************************* */
/* *** Console ( C++ )         *** */
/* ******************************* */

// ******************
// **** INCLUDES ****
// ******************
#include "Console.h"


// **************
// **** MAIN ****
// **************
int main(int argc, char ** argv) {

    // -------------------
    // --- Definitions ---
    // -------------------
    // Sockets
    int sockfd;
    bool Work = true;
    std::string Command;

    // Console stuff
    char LED_Address_hex[] = "02000010";
    char LED_Data_hex[] = "FFFFFFFF";

    // ------------
    // --- Main ---
    // ------------

    // Main loop 
    while (Work)
    {
	std::cout << "[]";
	std::cin >> Command;
	std::cout << std::endl;
    }

    // Open client socket

//    std::cout << "WRITE_ADDR 0x" << LED_Address_hex << " Data " << LED_Data_hex << std::endl;

//    SerialCommTypes::t_SerialTransaction v_Transaction(LED_Address_hex,LED_Data_hex);
//    v_Transaction.serialize();
//
//    sockfd = ITC::ITC_connect_to_server(PORT_SERIALCOMM);
//    ITC::ITC_write(sockfd,v_Transaction.v_Serialized,16);
//    sockfd = ITC::close_client(sockfd);

    // Exit
    return 0;

}
