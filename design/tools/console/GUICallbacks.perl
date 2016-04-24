#!/usr/bin/perl

#################
### LIBRARIES ###
#################
require "Widgets.perl";
require "Protocols.perl";
require "Geometry.perl";
require "Drawing.perl";
require "Utils.perl";
require "GlobalVars.perl";

use Device::SerialPort;
use Gtk2;
use Gtk2::Pango;
use POSIX;

#################
### FUNCTIONS ###
#################

sub ReadValues {

  my $NbBlock = $_[0];

  my $port = OpenConnection();

  # Update the console text
  my $iter = $Widgets::ConsoleBuffer->get_end_iter;
  $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, 
						     "Reading block " . $NbBlock . 
						     " from ADDRESS "  . $Widgets::AddressEntry->get_text() .
						     "\n",
						     "bold");

  #$Address = hex($Widgets::AddressEntry->get_text());
  $Address = hex($GlobalVars::LogicAnalyzerAddress);

  for (my $j = 0; $j < $GlobalVars::BlockLength; $j++)
    {

      $Data = ReadRegister($Address + $NbBlock*$GlobalVars::BlockLength,$port);
      my $Add = $Address + $NbBlock*$GlobalVars::BlockLength;
      my $myHexValue = sprintf("%x", $Add);
      $Widgets::LogicAnalyzerLastAddressReadEntry->set_text($myHexValue);

      $GlobalVars::DataRead[$j + $GlobalVars::Block*$GlobalVars::BlockLength] = $Data;
      my $aux = dec2bin(hex($Data));
      my @chars = split(//,$aux);
      my @pos;
      my $s = scalar @chars;

      $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, "\t\ts = " . $s . "\n" );

      for (my $i = 0; $i < 32; $i++)
	{
	  $pos[$i] = 0;
	  if ($i >= 32 - $s)
	    {
	      my $ind = $s + $i - 32;
	      $pos[$i] = $chars[$ind];
	    }
	  $GlobalVars::LogicAnalyzerMatrix[31 - $i][$j] = $pos[$i];
	}

      $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, "\tDATA READ " . $Data . "\n" );

      for (my $i = 0; $i < 32; $i++)
	{
	  $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, "\t\tDATA " . $i . " - " . $pos[$i] . "\n" );
	  if (($j eq 0) and ($NbBlock eq 0))
	    {
	      if ($GlobalVars::LogicAnalyzerMatrix[$i][0] eq 0)
		{
		  draw_X_0(30,($i+1)*$Geometry::Scale*10);
		} else {
		  draw_X_1(30,($i+1)*$Geometry::Scale*10);
		}
	    } else {

	      my $S = $Geometry::Scale*10;

	      if ($GlobalVars::LogicAnalyzerMatrix[$i][$j] eq 0)
		{
		  if ($GlobalVars::LogicAnalyzerMatrix[$i][$j-1] eq 1) { draw_1_0(30+$j*$S+$NbBlock*$GlobalVars::BlockLength*$S,($i+1)*$S); }
		  if ($GlobalVars::LogicAnalyzerMatrix[$i][$j-1] eq 0) { draw_0_0(30+$j*$S+$NbBlock*$GlobalVars::BlockLength*$S,($i+1)*$S); }
		} else {
		  if ($GlobalVars::LogicAnalyzerMatrix[$i][$j-1] eq 1) { draw_1_1(30+$j*$S+$NbBlock*$GlobalVars::BlockLength*$S,($i+1)*$S); }
		  if ($GlobalVars::LogicAnalyzerMatrix[$i][$j-1] eq 0) { draw_0_1(30+$j*$S+$NbBlock*$GlobalVars::BlockLength*$S,($i+1)*$S); }
		}
	    }
	}

      $Address = $Address +1;

      while (Gtk2->events_pending) { Gtk2->main_iteration();}

    }

}

sub LogicAnalyzerLaunch_button_clicked {

  my ($widget)= @_;

  ReadValues($GlobalVars::Block);


  #good practice to let the event propagate, should we need it somewhere else
  return FALSE;	

}


# This function shows in teh screen the address value for a
# particular position of the marker and the value that has
# been read from that position
sub LogicAnalyzerClicked_button_clicked {

  my ($widget,$event)= @_;

  my ($x,$y) = $widget->parent->w2i ($event->coords);
  warn "event ".$event->type."\n";

  if ($event->type eq 'button-press') {
    if ($event->button == 1) {
      my $points1 = [$x,0,$x,$Geometry::CanvasHeightMax];
      if ($GlobalVars::Marker1Exists eq 1) { $Widgets::Marker1->destroy; }
      $Widgets::Marker1 = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
						     points => $points1,
						     width_units => 2,
						     cap_style => 'projecting',
						     fill_color => 'green',
						     line_style => 'solid',
						     join_style => 'miter');
      $GlobalVars::Marker1Exists = 1;
      my $Value = floor(($x-30-$Geometry::Scale*5)/($Geometry::Scale*10));
      $Widgets::LogicAnalyzerMarkerEntry->set_text($Value);
      

    }
    if ($event->button == 3) {
      my $points1 = [$x,0,$x,$Geometry::CanvasHeightMax];
      if ($GlobalVars::Marker2Exists eq 1) { $Widgets::Marker2->destroy; }
      $Widgets::Marker2 = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
						     points => $points1,
						     width_units => 2,
						     cap_style => 'projecting',
						     fill_color => 'blue',
						     line_style => 'solid',
						     join_style => 'miter');
      my $Value = floor(($x-30-$Geometry::Scale*5)/($Geometry::Scale*10));
      $Widgets::LogicAnalyzerMarkerValueEntry->set_text($GlobalVars::DataRead[$Value]);

      my $HexVal = hex($GlobalVars::LogicAnalyzerAddress);
      my $myHexValue = sprintf("%x", $HexVal+$Value);

      $Widgets::LogicAnalyzerMarkerAddressEntry->set_text($myHexValue);
      $GlobalVars::Marker2Exists = 1;
    }
  }




  #good practice to let the event propagate, should we need it somewhere else
  return FALSE;	

}

sub LogicAnalyzerMore_button_clicked {

  my ($widget)= @_;

  $GlobalVars::Block = $GlobalVars::Block + 1;

  ReadValues($GlobalVars::Block);

  #good practice to let the event propagate, should we need it somewhere else
  return FALSE;	

}

sub read_button_clicked {

  my ($widget)= @_;

  my $port = OpenConnection();

  # Update the console text
  my $iter = $Widgets::ConsoleBuffer->get_end_iter;
  $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, 
						     "Reading" .
						     " from ADDRESS "  . $Widgets::AddressEntry->get_text() .
						     "\n",
						     "bold");

  $Address = hex($Widgets::AddressEntry->get_text());

  $Data = ReadRegister($Address,$port);

  my $aux = dec2bin(hex($Data));
  my @chars = split(//,$aux);
  my @pos;

  for (my $i = 0; $i < 32; $i++)
    {
      if ($i < scalar @chars)
	{
	  $pos[$i] = $chars[$i];
	} else {
	  $pos[$i] = 0;
	}
    }

  $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, "\tDATA READ " . $Data . "\n" );
  for (my $i = 0; $i < 32; $i++)
    {
      $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, "\t\tDATA " . $i . " - " . $pos[$i] . "\n" );
    }

  $Widgets::DataEntry->set_text($Data);

  #good practice to let the event propagate, should we need it somewhere else
  return FALSE;	
}

sub write_button_clicked {

  my ($widget)= @_;

  my $port = OpenConnection();

  # Update the console text
  my $iter = $Widgets::ConsoleBuffer->get_end_iter;
  $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, 
						     "Writing DATA " . $Widgets::DataEntry->get_text() .
						     " in ADDRESS "  . $Widgets::AddressEntry->get_text() .
						     "\n",
						     "bold");
  #WriteRegister($Widgets::DataEntry->get_text(),$Widgets::AddressEntry->get_text(),$port);

  $Address = hex($Widgets::AddressEntry->get_text());
  $Data    = hex($Widgets::DataEntry->get_text());


  $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, 
						     "\tAddress " . $Address . "\n" .
						     "\tData1 " . $Data . "\n"
						    );

  while (Gtk2->events_pending) { Gtk2->main_iteration();}

  WriteRegister($Address,$Data,$port);

  $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, "\tDone\n " );

  #good practice to let the event propagate, should we need it somewhere else
  return FALSE;	
}

sub program_button_clicked {

  my ($widget)= @_;

  my $port = OpenConnection();
  my $PROGRAM_NAME = $Widgets::FlashFileNameEntry->get_text();

  # Update the console text
  my $iter = $Widgets::ConsoleBuffer->get_end_iter;
  $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, 
						     "Programming file " . $PROGRAM_NAME .
						     "\n",
						     "bold");

  while (Gtk2->events_pending) { Gtk2->main_iteration();}

  my ($Lines, $NbLines) = ReadFile($Widgets::FlashFileNameEntry->get_text());

  my $NbGroups32Bytes = $NbLines / 8; # We calculate the number of groups of 32 bytes
  my @Group;

  for ( my $i=0; $i < $NbGroups32Bytes - 1; $i++) # (the -1 is to remove the E2 block"
    {

      $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, 
							 "Sending group " . $i . " / " . ($NbGroups32Bytes - 1) .
							 "\n",
							 "bold");
      for ($j = 0; $j < 8; $j++)
	{
	  $Group[$j] = $Lines[$i*8 + $j];
	}
      WriteFlash($Group);
    }

  $Widgets::ConsoleBuffer->insert_with_tags_by_name ($iter, "\t" . $NbLines . " read\n " );


  #good practice to let the event propagate, should we need it somewhere else
  return FALSE;	
}


1

