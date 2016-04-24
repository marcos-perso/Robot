#!/usr/bin/perl -w

################
### INCLUDES ###
################
use strict;
use Gtk2 '-init';
use Device::SerialPort;
require "SerialCom.perl";
require "GUIStructure.perl";

#################
### CALLBACKS ###
#################

sub hello
{
  my ($widget, $window1) = @_;
  print "Hello, World\n";
  $window1->destroy;
}

sub delete_event
{

  # If you return FALSE in the "delete_event" signal handler,
  # GTK will emit the "destroy" signal. Returning TRUE means
  # you don't want the window to be destroyed.
  # This is useful for popping up 'are you sure you want to quit?'
  # type dialogs.
  print "delete event occurred\n";

  # Change TRUE to FALSE and the main window will be destroyed with
  # a "delete_event".
  return 1;

}

########################
### CREATE STRUCTURE ###
########################
my $window = Gtk2::Window->new('toplevel');
my $box    = Gtk2::VBox->new('0', 5);
$box->pack_start(create_addressRW(),'0','0',0);
$box->pack_start(create_flash_section(),'0','0',0);
$box->pack_start(create_console(),'0','0',0);
$box->pack_start(create_canvas_section(),'1','1',0);
$window->add($box);

#####################
### CREATE FORMAT ###
#####################
$window->set_border_width(10);

#########################
### SIGNAL CONNECTION ###
#########################
#$window->signal_connect(delete_event => \&delete_event);
$window->signal_connect(delete_event => sub {Gtk2->main_quit();});

####################
### SHOW WIDGETS ###
####################

$box->show_all;
$window->show;

#################
### MAIN LOOP ###
#################
Gtk2->main;

0;


