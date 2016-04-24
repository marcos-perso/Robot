#!/usr/bin/perl

#################
### LIBRARIES ###
#################

#################
### FUNCTIONS ###
#################

#################
### VARIABLES ###
#################

############
### MAIN ###
############

## Get command line arguments

if ($ARGV[0] eq "-h")
  {
   print "launcher.perl <TEST> <DURATION> <WAVES>" . "\n";
   print "\t<TEST> Test name\n";
   print "\t<DURATION> Duration of the test in ms.\n";
   print "\t\t 0: Read duration from time.in in the regression directory\n";

  } else {

    # Get the variables
    my $TEST     = $ARGV[0];
    my $DURATION = $ARGV[1];
    my $WAVES    = $ARGV[2];
    my $PATH_TO_TEST = "./Regression/" . $TEST;

    # Prepare the environment:
    print "Preparing environment...\n";
    system("$PATH_TO_TEST/environment.sh");
    my $Command = "./simulation2";
    if ($WAVES eq "1") { $Command .= " --wave=run.ghw"; } else {}

    # If teh time is given in a file, open it
    if ($DURATION eq 0)
      {
	my $time_filename = $PATH_TO_TEST . '/time.in';
	open(my $fh, '<:encoding(UTF-8)', $time_filename)
	  or die "Could not open file '$time_filename' $!";

	while (my $row = <$fh>) {
	  chomp $row;
	  $DURATION = $row;
	}
      }

    $Command .= " --stop-time=" . $DURATION . "us";

    print "TEST    : $TEST" . "\n";
    print "DURATION: $DURATION" . "\n";
    print "WAVES   : $WAVES" . "\n";

    # Prepare the command to be launched
    print "Launching test...\n";
    print $Command ."\n";
    exec($Command) == 0 or die "system @args failed: $?"
    #exec("./simulation2 --wave=run.ghw --disp-tree=inst ") == 0 or die "system @args failed: $?"


}
