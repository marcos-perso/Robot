#!/usr/bin/perl

#################
### LIBRARIES ###
#################
use Device::SerialPort;
require "SerialCom.perl";
require "Protocols.perl";
require "Widgets.perl";

#################
### FUNCTIONS ###
#################

## Print in a given output 
##  ARG1: Data to print
sub PrintoutGUI
  {

    my $Data = $_[0];

    my $iter = $Widgets::ConsoleBuffer->get_end_iter;
    $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, 
						       $Data .
						       "\n" );

  }

1
