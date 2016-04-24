#!/usr/bin/perl

#################
### LIBRARIES ###
#################

#################
### FUNCTIONS ###
#################

package Widgets;

$NbEntriesEntry     = Gtk2::Entry->new();
$NbEntriesLabel     = Gtk2::Label->new();
$ShowFlashButton    = Gtk2::Button->new("Show");
$AddressLabel       = Gtk2::Label->new();
$AddressEntry       = Gtk2::Entry->new();
$DataLabel          = Gtk2::Label->new();
$DataEntry          = Gtk2::Entry->new();
$WriteButton        = Gtk2::Button->new("Write");
$ReadButton         = Gtk2::Button->new("Read");
$FlashFileNameLabel = Gtk2::Label->new();
$FlashFileNameEntry = Gtk2::Entry->new();
$ProgramButton      = Gtk2::Button->new("Program");
$CheckButton        = Gtk2::Button->new("Check");
$ConsoleBuffer      = Gtk2::TextBuffer->new();
$LogicAnalyzerLaunchButton = Gtk2::Button->new("Launch LA");
$LogicAnalyzerMoreButton   = Gtk2::Button->new("More");
$LogicAnalyzerLastAddressReadLabel  = Gtk2::Label->new();
$LogicAnalyzerLastAddressReadEntry  = Gtk2::Entry->new();
$LogicAnalyzerMarkerAddressLabel  = Gtk2::Label->new();
$LogicAnalyzerMarkerValueLabel  = Gtk2::Label->new();
$LogicAnalyzerMarkerValueEntry  = Gtk2::Entry->new();
$LogicAnalyzerMarkerAddressEntry  = Gtk2::Entry->new();

my $LogicAnalyzerCanvas;


###############
### Objects ###
###############


1

