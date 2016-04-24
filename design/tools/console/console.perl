#!/usr/bin/perl

#################
### LIBRARIES ###
#################
use Device::SerialPort;
require "SerialCom.perl";
require "Protocols.perl";
require "Utils.perl";

#################
### FUNCTIONS ###
#################

#################
### VARIABLES ###
#################

my $InputLine;

############
### MAIN ###
############

my $port = OpenConnection();
my $ProgramName = "None";

while (1)
  {  # -- 1 --

## Print the header
    PrintPrompt();

## Get a line
    $line = <STDIN>;

## Analyze the line
    Printout($line . "\n",0);
    # Separate into words
    @SPLIT_LINE = split ' ', $line;
    $NbWords = scalar(@SPLIT_LINE);
    Printout("# words : " . $NbWords . "\n",0);


## Result
    if (exists($SPLIT_LINE[0]))

	{ ## -- 2 --

	  $First = $SPLIT_LINE[0];

	  # QUIT
	  if (($First eq "quit") or ($First eq "q"))
	    { # -- 3 --
	      Printout("Bye". "\n",0);
	      exit(0);
	    } # -- 3 --

	  # HELP
	  if (($First eq "help") or ($First eq "h"))
	    { # -- 4 --
	      Printout("quit (q)       :". "\t" . "Terminate the console" . "\n",0);
	      Printout("help (h)       :". "\t" . "Shows this help" . "\n",0);
	      Printout("WRITE_FLASH    :". "\t" . "Writes the contents of the prgram into flash" . "\n",0);
	      Printout("READ_FLASH     :". "\t" . "Reads the contents of the FLASH" . "\n",0);
	      Printout("ERASE_FLASH_SECTOR:". "\t" . "Erases FLASH sector" . "\n",0);
	      Printout("\t" . "ERASE_FLASH_SECTOR <16#SECTOR>" . "\n",0);
	      Printout("COMPARE_PROGRAM:". "\t" . "Compares the program with what has been read form the FLASH" . "\n",0);
	      Printout("WRITE_ADDR (WA) :". "\t" . "Write to a specific address" . "\n",0);
	      Printout("\t" . "WRITE_ADDR <0xADDRESS> <0xDATA>" . "\n",0);
	      Printout("READ_ADDR (RA)  :". "\t" . "Read from a specific address" . "\n",0);
	      Printout("\t" . "READ_ADDR <0xADDRESS>" . "\n",0);
	      Printout("WRITE_REG (WR) :". "\t" . "Write to a specific register" . "\n",0);
	      Printout("\t" . "WRITE_REG <REGISTER> <0xDATA>" . "\n",0);
	      Printout("WRITE_REG (RR) :". "\t" . "Read from a specific register" . "\n",0);
	      Printout("\t" . "READ_REG <REGISTER>" . "\n",0);
	    } # -- 4 --

	  ########################
	  ##### READ_PROGRAM #####
	  ########################

	  if ($First eq "WRITE_FLASH")
	    {

	      if (exists($SPLIT_LINE[1]))

		{

		  $Second = $SPLIT_LINE[1];

		  # Convert HEX to INT
		  my $PROGRAM_NAME = $Second;

		  Printout("-- READING TEST ---". "\n",0);
		  my ($Lines, $NbLines) = ReadFile($PROGRAM_NAME);
		  my $NbGroups32Bytes = $NbLines / 8; # We calculate the number of groups of 32 bytes
		  Printout("-- FILE READ ---". "\n",0);
		  Printout("NbLines  : ". $NbLines . "\n",0);
		  Printout("Nb groups: ". $NbGroups32Bytes . "\n",0);

		  for ( my $i=0; $i < $NbGroups32Bytes - 1; $i++) # (the -1 is to remove the E2 block"
		    {

		      Printout("--- Group # --- " . $i . "\n",0);

		      for ($j = 0; $j < 8; $j++)
			{
			  $sector = $i*8 + $j;
			  #Printout("--- Sector " . $sector . "\n",0);
			  WriteFlashSector($$Lines[$sector],$port);
			}
		      TriggerProgrammingSector($port);

		    }

		} else { # -- 6 --
		  Printout("Syntax error. Missing file name". "\n",0);
		}
	    }

	  #########################
	  ##### ADDRESS WRITE #####
	  #########################
	  if (($First eq "WRITE_ADDR") or ($First eq "WA"))
	    { # -- 5 --
	      if (exists($SPLIT_LINE[1]))
		{ # -- 6 --
		  $Second = $SPLIT_LINE[1];

		  # Convert HEX to INT
		  my $Address = hex("$Second");

		  if (exists($SPLIT_LINE[2]))
		    {
		      $Third = $SPLIT_LINE[2];
		      # Convert HEX to INT
		      my $Data = hex("$Third");

		      Printout("-- WRITE in ADDRESS ---". "\n",0);
		      Printout("WRITE_ADDR " . "$Address" . " " . "$Data" . "\n",0);


		      $port->write(chr(1));                    # Command write
		      $port->write(chr($Address));             # write Address
		      $port->write(chr($Data));                # write Data

		      my $Info = ReadByte($port);

		      print "Received : " . $Info . "\n";

		    } else {
		      Printout("Syntax error. Missing data". "\n",0);
		    }
		} else { # -- 6 --
		  Printout("Syntax error. Missing address". "\n",0);
		} # -- 6 --
	    } # -- 5 --

	  ##############################
	  ##### ERASE FLASH SECTOR #####
	  ##############################
	  if (($First eq "ERASE_FLASH_SECTOR") or ($First eq "EFS"))
	    {
	      if (exists($SPLIT_LINE[1]))
		{
		  $Second = $SPLIT_LINE[1];
		  my $Sector = hex("$Second");
		  my $Address = hex("2000025");
		  Printout("-- Erasing sector ---". "\n",0);
		  Printout("ERASE SECTOR " . "$Sector" . "\n",0);
		  # Write in the sector register
		  WriteRegister($Address,$Sector,$port);
		  $Address = hex("2000020");
		  $Data    = hex("6");
		  WriteRegister($Address,$Data,$port);
		} else {
		  Printout("Syntax error. Missing sector". "\n",0);
		}
	    }

	  ########################
	  ##### ADDRESS READ #####
	  ########################
	  if (($First eq "READ_ADDR") or ($First eq "RA"))
	    {
	      if (exists($SPLIT_LINE[1]))
		{
		  $Second = $SPLIT_LINE[1];

		  # Convert HEX to INT
		  my $Address = hex("$Second");

		  Printout("-- READ from ADDRESS ---". "\n",0);
		  Printout("READ_ADDR " . "$Address" . "\n",0);

		  $port->write(chr(2));                    # Command write
		  $port->write(chr($Address));             # write Address

		  my $Info = ReadByte($port);

		  print "Received : " . $Info . "\n";

		} else {
		  Printout("Syntax error. Missing address". "\n",0);
		}
	    }
	  ##########################
	  ##### REGISTER WRITE #####
	  ##########################
	  if (($First eq "WRITE_REG") or ($First eq "WR"))
	    {

	      if (exists($SPLIT_LINE[1])) # We check that we have an "address field"
		{
		  $Second = $SPLIT_LINE[1];

		  # Convert HEX to INT
		  my $Address = hex("$Second");

		  if (exists($SPLIT_LINE[2]))
		    {
		      $Third = $SPLIT_LINE[2];
		      # Convert HEX to INT
		      my $Data = hex("$Third");

		      WriteRegister($Address,$Data,$port);

		    } else {
		      Printout("Syntax error. Missing data". "\n",0);
		    }
		} else { # -- 6 --
		  Printout("Syntax error. Missing address". "\n",0);
		} # -- 6 --
	    } # -- 5 --
	  #########################
	  ##### REGISTER READ #####
	  #########################
	  if (($First eq "READ_REG") or ($First eq "RR"))
	    {

	      if (exists($SPLIT_LINE[1])) # We check that we have an "address field"
		{
		  $Second = $SPLIT_LINE[1];

		  # Convert HEX to INT
		  my $Address = hex("$Second");

		  Printout("-- READ From REGISTER ---". "\n",0);
		  Printout("READ_REG " . "$Address" . "\n",0);

		  my $Result = ReadRegister($Address,$port);
		  Printout("READ Data: " . "$Result" . "\n",0);

		} else { # -- 6 --
		  Printout("Syntax error. Missing address". "\n",0);
		} # -- 6 --
	    } # -- 5 --




	} # -- 2 --

  }  # -- 1 --
