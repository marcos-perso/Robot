#!/usr/bin/perl

#################
### LIBRARIES ###
#################
use Device::SerialPort;
require "SerialCom.perl";

#################
### FUNCTIONS ###
#################

sub WriteAddress
  {

    my $RegisterAddress = $_[0];
    my $RegisterData    = $_[1];
    my $port            = $_[2];

    $port->write(chr(1));
    $port->write(chr($RegisterAddress));
    $port->write(chr($RegisterData));
    my $ReturnedByte = ReadByte($port);

    return $ReturnedByte;

  }

sub WriteByte
  {

    my $RegisterData    = $_[0];
    my $port            = $_[1];

    $port->write(chr($RegisterData));

  }

sub ReadAddress
  {

    my $RegisterAddress = $_[0];
    my $port            = $_[1];

    $port->write(chr(2));
    $port->write(chr($RegisterAddress));
    my $DataRead = ReadByte($port);

    return $DataRead;

  }

sub WriteRegister
  {


    my $Address = $_[0];
    my $Data    = $_[1];
    my $port    = $_[2];

    # We divide address in bytes
    $Address_4 = $Address   % 256;
    $tmp       = int($Address   / 256);
    $Address_3 = $tmp       % 256;
    $tmp       = int($tmp / 256);
    $Address_2 = $tmp       % 256;
    $tmp       = int($tmp / 256);
    $Address_1 = $tmp       % 256;
    $tmp       = int($tmp / 256);

    # We divide dat in bytes
    $Data_4 = $Data   % 256;
    $tmp       = int($Data   / 256);
    $Data_3 = $tmp       % 256;
    $tmp       = int($tmp / 256);
    $Data_2 = $tmp       % 256;
    $tmp       = int($tmp / 256);
    $Data_1 = $tmp       % 256;
    $tmp       = int($tmp / 256);

    my $Info;
    $Info = WriteAddress(1,$Address_1,$port);
    $Info = WriteAddress(2,$Address_2,$port);
    $Info = WriteAddress(3,$Address_3,$port);
    $Info = WriteAddress(4,$Address_4,$port);
    $Info = WriteAddress(5,$Data_1,$port);
    $Info = WriteAddress(6,$Data_2,$port);
    $Info = WriteAddress(7,$Data_3,$port);
    $Info = WriteAddress(8,$Data_4,$port);
    $Info = WriteAddress(0,1,$port);
  }


sub ReadRegister
  {

    my $Address = $_[0];
    my $port    = $_[1];

    # We divide address in bytes
    $Address_4 = $Address   % 256;
    $tmp       = int($Address   / 256);
    $Address_3 = $tmp       % 256;
    $tmp       = int($tmp / 256);
    $Address_2 = $tmp       % 256;
    $tmp       = int($tmp / 256);
    $Address_1 = $tmp       % 256;
    $tmp       = int($tmp / 256);

    my $Info;
    $Info = WriteAddress(1,$Address_1,$port);
    $Info = WriteAddress(2,$Address_2,$port);
    $Info = WriteAddress(3,$Address_3,$port);
    $Info = WriteAddress(4,$Address_4,$port);
    $Info = WriteAddress(0,2,$port);

    # Now we read the data from the bytes
    #We let 1 second in order to to the internal update in the FPGA
    #sleep(1);
    my $Result = 0;

    $Info = ReadAddress(5,$port);
    $Result = $Result + $Info * 256 * 256 * 256;
    print " R5: $Info ";
    $Info = ReadAddress(6,$port);
    $Result = $Result + $Info * 256 * 256;
    print " R6: $Info ";
    $Info = ReadAddress(7,$port);
    $Result = $Result + $Info * 256;
    print " R7: $Info ";
    $Info = ReadAddress(8,$port);
    $Result = $Result + $Info;
    print " R8: $Info ";

    my $ResultHex = uc(sprintf("%x", $Result));

    return $ResultHex;


  }

sub WriteFlashSector
    {
      my $Line = $_[0];
      my $port  = $_[1];
      my $Info;
      my $Confirm;

      $port->write(chr(3));
      #sleep(1);

      my @Splitted = split(//,$Line);
      #Printout("\t Writing: " . $Line . "\n",0);

      my $FirstByte  = $Splitted[0] . $Splitted[1];
      my $SecondByte = $Splitted[2] . $Splitted[3];
      my $ThirdByte  = $Splitted[4] . $Splitted[5];
      my $FourthByte = $Splitted[6] . $Splitted[7];

      $Info = WriteByte(hex($FirstByte),$port);
      $Confirm = ReadByte($port);

      $Info = WriteByte(hex($SecondByte),$port);
      $Confirm = ReadByte($port);

      $Info = WriteByte(hex($ThirdByte),$port);
      $Confirm = ReadByte($port);

      $Info = WriteByte(hex($FourthByte),$port);
      $Confirm = ReadByte($port);

    }

sub TriggerProgrammingSector
    {
      my $port  = $_[0];
      my $Confirm;

      # Send the command to copy the contents of the intermediate RAM to the FLASH
      $port->write(chr(4));
      $Confirm = ReadByte($port);
      #Printout("\tReceived confirmation " . $Confirm . "\n",0);
      #sleep(1);

    }

1
