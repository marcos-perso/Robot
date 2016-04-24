//
// This software is free to use by anyone for any purpose.
//
// -------------------------------------------------------------------------------
// -- DESCRIPTION: 
// -- Program to turn a binary file into a VHDL lookup table.
// --   by Adam Pierce
// --   29-Feb-2008
// --   This software is free to use by anyone for any purpose.
// --   Modified to accept multiple output formats
// --     VHDL ==> prepared to VHDL
// --     RAW  ==> Only raw output
// --
// -- NOTES:
// --
// -- $Author: mmartinez $
// -- $Date: 2010-07-01 16:58:08 $
// -- $Name:  $
// -- $Revision: 1.2 $
// --
// -------------------------------------------------------------------------------

#include <unistd.h>
#include <stdio.h>
#include <stdint.h>
#include <math.h>

typedef uint8_t BYTE;

main(int argc, char **argv)
{
       BYTE    opcode[4];
       int     fd;
       int     fd1;
       int     addr = 0;
       ssize_t s;
       long    max_addr = 0;
       long    h;

// Check the user has given us an input file.
       if(argc < 3)
       {
               printf("Usage: %s [VHDL/RAW/COE/SER/SIM] <binary_file>\n\n", argv[0]);
               return 1;
       }

       if (strcmp(argv[1],"COE") == 0)
       {
	   printf("; coe file\n");
	   printf("memory_initialization_radix=16;\n");
	   printf("memory_initialization_vector=\n");

       }

       if (strcmp(argv[1],"SIM") == 0)
       {
	   printf("@00000000\n");
       }

       // First pass. Gets the number of lines
       fd1 = open(argv[2], 0);
       if(fd1 == -1)
       {
               perror("File Open");
               return 2;
       }

       while(read(fd1,opcode,4) > 0)
       {
	   max_addr++;
       }
       close(fd1);
       


       // Second pass. Write results
       // Open the input file.
       fd = open(argv[2], 0);
       if(fd == -1)
       {
               perror("File Open");
               return 2;
       }

       while(1)
       {
       // Read 32 bits.
	   s = read(fd, opcode, 4);
	   if(s == -1)
	   {
	       perror("File read");
	       return 3;
	   }

	   if(s == 0)
	       break; // End of file.
	   
	   // Output to STDOUT depending of the chosen format
	   if (strcmp(argv[1],"VHDL") == 0)
	   {
	       printf("%6d => x\"%02x%02x%02x%02x\",\n",
		      addr++, opcode[0], opcode[1],
		      opcode[2], opcode[3]);
	   }
	   if (strcmp(argv[1],"RAW") == 0)
	   {
	       printf("%02x%02x%02x%02x,\n",
		      opcode[0], opcode[1],
		      opcode[2], opcode[3]);
	       addr++;
	   }
	   if (strcmp(argv[1],"COE") == 0)
	   {
	       if (addr == max_addr - 1)
	       {
		   printf("%02x%02x%02x%02x;\n",
			  opcode[0], opcode[1],
			  opcode[2], opcode[3]);
		   addr++;
	       } else {
		   printf("%02x%02x%02x%02x,\n",
			  opcode[0], opcode[1],
			  opcode[2], opcode[3]);
		   addr++;
	       }
		   
	   }
	   if (strcmp(argv[1],"SIM") == 0)
	   {
	       printf("%02x\n%02x\n%02x\n%02x\n",
		      opcode[3], opcode[2],
		      opcode[1], opcode[0]);
	       addr++;
		   
	   }
	       
       }

       close(fd);
       return 0;
}

// -------------------------------------------------------------------------------
// -- $Log: zpuromgen.c,v $
// -- Revision 1.2  2010-07-01 16:58:08  mmartinez
// -- Added COE functionality
// --
// -------------------------------------------------------------------------------
