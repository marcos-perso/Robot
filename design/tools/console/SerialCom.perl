#!/usr/bin/perl

#################
### LIBRARIES ###
#################
use Device::SerialPort;

## Open communication through serial port
sub OpenConnection
  {
    my $port = Device::SerialPort->new("/dev/ttyACM0");
    $port->databits(8);
    #$port->baudrate(115200);
    #$port->baudrate(460800);
    $port->baudrate(230400);
    $port->parity("none");
    $port->stopbits(1);

   # $port->read_char_time(0);     # don't wait for each character
    $port->read_const_time(5); # 1 second per unfulfilled "read" call

    return $port;
  }

## Read a byte from the serial port
sub ReadByte

    {

      $port = $_[0];   ## Serial port to be used

      my $STALL_DEFAULT=10; # how many seconds to wait for new input
      my $timeout=$STALL_DEFAULT;
      my $chars=0;
      my $buffer="";
      my $count_in;

      while ($timeout>0) {
	my ($count,$saw) =$port->read(255); # will read _up to_ 255 chars
	if ($count > 0) {
	  $chars+=$count;
	  $buffer.=$saw;
	  $count_in = $count;

	  # Check here to see if what we want is in the $buffer
	  # say "last" if we find it
	  #last if ($buffer eq chr(1));
	  last if ($count_in == 1);
	}
	else {
	  $timeout--;
	}
      }

      if ($timeout==0) {
	die "Waited $STALL_DEFAULT seconds and never saw what I wanted\n";
      }

return ord($buffer);
}
1

