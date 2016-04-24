#!/usr/bin/perl

#################
### LIBRARIES ###
#################

#################
### FUNCTIONS ###
#################

## Print in a given output 
##  ARG1: Data to print
##  ARG2: 0: to screen 1: to console widget
sub Printout
  {

    my $Data = $_[0];
    my $Type = $_[1];

    if ($Type == 0)
      {
	print $Data;
      }

  }

## Print the console prompt
sub PrintPrompt
    {
      Printout('my-vssr :: ',0);
    }

## Open a file and put the contents in a buffer
sub ReadFile {

  # Inputs
  my $FileName = $_[0];

  # Variables
  my @MyReadFile;
  my $linea;
  my $num_line = 0;

  # Opening the file
  my $INPUT_FILE = "<" . $FileName;
  open (INPUT_FILE,$INPUT_FILE) or die "Impossible to open file $INPUT_FILE";

  # Iterate through the file
  while ($linea = <INPUT_FILE>)
    {
      chomp($linea);
      $MyReadFile[$num_line] = $linea;
      $num_line++;
    }

  # Returns
  return (\@MyReadFile,$num_line);

}

sub dec2bin {
    my $str = unpack("B32", pack("N", shift));
    $str =~ s/^0+(?=\d)//;   # otherwise you'll get leading zeros
    return $str;
}

sub bin2dec {
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}

sub round {
  my($number) = shift;
  return int($number + .5 * ($number <=> 0));
}


1
