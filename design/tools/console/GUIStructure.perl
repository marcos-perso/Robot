#!/usr/bin/perl

#################
### LIBRARIES ###
#################
require "Widgets.perl";
require "Protocols.perl";
require "Geometry.perl";
require "GUICallbacks.perl";
require "GlobalVars.perl";

use Device::SerialPort;
use Gtk2::Pango;
use Gnome2::Canvas;

#################
### FUNCTIONS ###
#################

sub create_canvas_section {

  # Initialize
  for (my $i = 0; $i < 32; $i++) { $GlobalVars::LogicAnalyzerLastValues[$i] = 2; }

  # Create structures
  my $frame = Gtk2::Frame->new("LogicAnalyzer");
  my $Hbox   = Gtk2::HBox->new('0', 5);
  my $Vbox   = Gtk2::VBox->new('0', 5);

  $Vbox->pack_start($Widgets::LogicAnalyzerLaunchButton,'0','0',0);
  $Vbox->pack_start($Widgets::LogicAnalyzerMoreButton,'0','0',0);

  my $HboxLastAddressRead   = Gtk2::HBox->new('0', 5);
  $Widgets::LogicAnalyzerLastAddressReadLabel->set_label("Max Address:");
  $HboxLastAddressRead->pack_start($Widgets::LogicAnalyzerLastAddressReadLabel,'0','0',0);
  $HboxLastAddressRead->pack_start($Widgets::LogicAnalyzerLastAddressReadEntry,'0','0',0);
  $HboxLastAddressRead->show_all();

  my $HboxAddressMarker   = Gtk2::HBox->new('0', 5);
  $Widgets::LogicAnalyzerMarkerAddressLabel->set_label("Address:");
  $HboxAddressMarker->pack_start($Widgets::LogicAnalyzerMarkerAddressLabel,'0','0',0);
  $HboxAddressMarker->pack_start($Widgets::LogicAnalyzerMarkerAddressEntry,'0','0',0);
  $HboxAddressMarker->show_all();

  my $HboxValueMarker   = Gtk2::HBox->new('0', 5);
  $Widgets::LogicAnalyzerMarkerValueLabel->set_label("Value:");
  $HboxValueMarker->pack_start($Widgets::LogicAnalyzerMarkerValueLabel,'0','0',0);
  $HboxValueMarker->pack_start($Widgets::LogicAnalyzerMarkerValueEntry,'0','0',0);
  $HboxValueMarker->show_all();


  $Vbox->pack_start($HboxLastAddressRead,'0','0',0);
  $Vbox->pack_start($HboxAddressMarker,'0','0',0);
  $Vbox->pack_start($HboxValueMarker,'0','0',0);

  $Vbox->show_all();

  my $scroller = Gtk2::ScrolledWindow->new(undef,undef);
  $scroller->set_shadow_type ('etched-out');
  $scroller->set_policy ("always", "always");
  $scroller->set_border_width(5);

  $Widgets::LogicAnalyzerCanvas = Gnome2::Canvas->new;

  my $root = $Widgets::LogicAnalyzerCanvas->root;
  $scroller->set_size_request ($Geometry::CanvasWidth,$Geometry::CanvasHeight);
  $Widgets::LogicAnalyzerCanvas->set_scroll_region (0, 0, $Geometry::CanvasWidthMax, $Geometry::CanvasHeightMax);


  $Widgets::LogicAnalyzerLaunchButton->signal_connect( 'clicked' => sub {
							my ($widget) = @_;
							#count is in the same namespace as the closure
							&LogicAnalyzerLaunch_button_clicked($widget,$event);
						      });

  $Widgets::LogicAnalyzerMoreButton->signal_connect( 'clicked' => sub {
						       my ($widget) = @_;
						       #count is in the same namespace as the closure
						       &LogicAnalyzerMore_button_clicked($widget,$event);
						     });

  # Build the grid
  BuildGrid();
  $GlobalVars::Marker1Exists = 0;
  $GlobalVars::Marker2Exists = 0;


  for (my $i = 0; $i < 32; $i++)
    {

      for (my $j = 0; $j < 256; $j++)
	{
	  # Intialize the matrix with values
	  $GlobalVars::LogicAnalyzerMatrx[$i][$j] = -1;
	  $GlobalVars::DataRead[$j] = 0;
	  $GlobalVars::Block = 0;
	}

      # Write the lines numbers
      Gnome2::Canvas::Item->new ($root, 'Gnome2::Canvas::Text',
				 x => 10,
				 y => ($i+1)*$Geometry::Scale*10,
				 fill_color => 'black',
				 font => 'Sans 10',
				 anchor => 'GTK_ANCHOR_NW',
				 text => $i);
    }

  for (my $i = 0; $i < 256; $i++)
    {
      # Write the column number
      Gnome2::Canvas::Item->new ($root, 'Gnome2::Canvas::Text',
				 x => 10 + $Geometry::Scale*10 + ($i+1)*$Geometry::Scale*10,
				 y => 10,
				 fill_color => 'black',
				 font => 'Sans 6',
				 anchor => 'GTK_ANCHOR_NW',
				 text => $i);
    }

  $scroller->add ($Widgets::LogicAnalyzerCanvas);

  $Hbox->pack_start($Vbox,'0','0',0);
  $Hbox->pack_start($scroller,'1','1',0);
  $Hbox->show_all();
  $frame->add($Hbox);
  $frame->show_all;




  return $frame;

}


sub create_flash_section {

  # Create the frame
  my $frame = Gtk2::Frame->new("Flash");
  my $box1   = Gtk2::HBox->new('0', 5);
  $Widgets::FlashFileNameLabel->set_label("File name:");
  $Widgets::NbEntriesLabel->set_label("# 32-bit Entries");
  $box1->pack_start($Widgets::FlashFileNameLabel,'0','0',0);
  $box1->pack_start($Widgets::FlashFileNameEntry,'0','0',0);
  $box1->pack_start($Widgets::ProgramButton,'0','0',0);
  $box1->pack_start($Widgets::CheckButton,'0','0',0);
  $box1->pack_start($Widgets::NbEntriesLabel,'0','0',0);
  $box1->pack_start($Widgets::NbEntriesEntry,'0','0',0);
  $box1->pack_start($Widgets::ShowFlashButton,'0','0',0);
  $box1->show_all();
  $frame->add($box1);

  # Connect signals
  $Widgets::ProgramButton->signal_connect('clicked' => sub {
					  my ($widget) = @_;
					  #count is in the same namespace as the closure
					  &program_button_clicked($widget,$event);
					});
  $Widgets::CheckButton->signal_connect('clicked' => sub {
					 my ($widget) = @_;
					 #count is in the same namespace as the closure
					 &check_button_clicked($widget,$event);
				       });
  $Widgets::ShowFlashButton->signal_connect('clicked' => sub {
					      my ($widget) = @_;
					      #count is in the same namespace as the closure
					      &showflash_button_clicked($widget,$event);
					    });

  # Return the frame
  return $frame;

}

sub create_buffer {
  	#-----------------------------------------------
  	#a standard buffer will typically be:
  	#1.) created
  	#2.) tags added to;
  	#3.) anchors, text, marks, and pixbuffs added to
  	#-----------------------------------------------
  	#create a net textbuffer
  	my $buffer = $Widgets::ConsoleBuffer;
  	#create a bunch of standard tags
  	$buffer->create_tag ("bold", weight => PANGO_WEIGHT_BOLD);
  	$buffer->create_tag ("big", size => 20 * PANGO_SCALE);
  	$buffer->create_tag ("italic", style => 'italic');
  	$buffer->create_tag ("grey_foreground", foreground => "grey");
  	#create a tag for the editable text (editable => TRUE)		
  	my $tag = $buffer->create_tag ("editable",
 					style =>'italic',
 					weight => PANGO_WEIGHT_ULTRALIGHT,
 					foreground => "blue",
 					editable => TRUE,
 					);
 	#a created tag is for all practical purposes a hash with keys and values.
 	#the "create_tag" method does not allow any additional keys, other than a standard set.
 	#here we add a key and value to the $tag hash JUST after creation. This will later be used
 	#when we check if the cursor must change.
 	$tag->{pointer} = "edit";
	
 	#we get the pointer to the start of the buffer, and add some content.
 	#after every addition, this pointer ($iter) will be pointing to
 	#a new place in the buffer. This works fine for sequencial additions
 	my $iter = $buffer->get_start_iter;
 	#tags is a list, thus they can be stacked to get desired results.
 	$buffer->insert_with_tags_by_name ($iter, "Console:\n", "bold","big","grey_foreground");
	
 	#return the finished buffer
 	return $buffer;

}

sub create_addressRW {

  # Create the frame
  my $frame = Gtk2::Frame->new("R/W");
  my $box1   = Gtk2::HBox->new('0', 5);
  $Widgets::AddressLabel->set_label("Address:");
  $Widgets::DataLabel->set_label("Data:");
  $box1->pack_start($Widgets::AddressLabel,'0','0',0);
  $box1->pack_start($Widgets::AddressEntry,'0','0',0);
  $box1->pack_start($Widgets::DataLabel,'0','0',0);
  $box1->pack_start($Widgets::DataEntry,'0','0',0);
  $box1->pack_start($Widgets::WriteButton,'0','0',0);
  $box1->pack_start($Widgets::ReadButton,'0','0',0);
  $box1->show_all();
  $frame->add($box1);

  # Connect signals
  $Widgets::WriteButton->signal_connect('clicked' => sub {
					  my ($widget) = @_;
					  #count is in the same namespace as the closure
					  &write_button_clicked($widget,$event);
					});
  $Widgets::ReadButton->signal_connect('clicked' => sub {
					 my ($widget) = @_;
					 #count is in the same namespace as the closure
					 &read_button_clicked($widget,$event);
				       });

  # Return the frame
  return $frame;

}

sub create_console {

  my $frame = Gtk2::Frame->new("Console");
  $frame->set_border_width(5);

  #create a scrolled window to put the textview in
  my $sw = Gtk2::ScrolledWindow->new (undef, undef);
  $sw->set_shadow_type ('etched-out');
  $sw->set_policy ('automatic', 'automatic');
  $sw->set_size_request ($Geometry::ConsoleWidth, $Geometry::ConsoleHeight);
  $sw->set_border_width(5);

  #we add this buffer to a new textview
  
  my $tview = Gtk2::TextView->new_with_buffer(&create_buffer);
  #$tview->signal_connect (motion_notify_event => \&motion_notify_event);
  $tview->set_editable(TRUE);			
  $sw->add($tview);
  $frame->add($sw);


  return $frame;

}

1

