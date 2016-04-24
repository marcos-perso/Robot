#!/usr/bin/perl

#################
### LIBRARIES ###
#################
require "Widgets.perl";

use Device::SerialPort;
use Gtk2;
use Gtk2::Pango;

#################
### FUNCTIONS ###
#################

sub BuildGrid {

  my $points1 = [0,2,$Geometry::CanvasWidthMax,2];

  my $Rule = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
					points => $points1,
					width_units => 2,
					cap_style => 'projecting',
					fill_color => 'green',
					line_style => 'solid',
					join_style => 'miter');

  $Rule->signal_connect( event => sub {
			   my ($widget,$event) = @_;
			   #count is in the same namespace as the closure
			   &LogicAnalyzerClicked_button_clicked($widget,$event);
			 });

  for (my $i = 0; $i < 32; $i++)
    {

      # Horizontal lines
      my $points = [0,$Geometry::Scale*9 + ($i+1)*$Geometry::Scale*10,
		    $Geometry::CanvasWidthMax,$Geometry::Scale*9 + ($i+1)*$Geometry::Scale*10];

      my $line = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
					points => $points,
					width_units => 0.1,
					cap_style => 'projecting',
					fill_color => 'red',
					line_style => 'on-off-dash',
					join_style => 'miter');
    }

  # Vertical lines
  for (my $i = 0; $i < 256; $i++)
    {
      my $points = [30 + $Geometry::Scale*5 + ($i)*$Geometry::Scale*10,0,30 + $Geometry::Scale*5 + ($i)*$Geometry::Scale*10,$Geometry::CanvasHeightMax,];
      my $line = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
					points => $points,
					width_units => 0.1,
					cap_style => 'projecting',
					fill_color => 'red',
					line_style => 'on-off-dash',
					join_style => 'miter');
    }



return $line;

}

sub draw_X_0 {

  my $x = $_[0];
  my $y = $_[1];


  my $box = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Rect',
                                       x1 => $x+$Geometry::Scale*1, y1 => $y+$Geometry::Scale*1,
                                       x2 => $x+$Geometry::Scale*5, y2 => $y+$Geometry::Scale*9,
                                       fill_color => 'red',
                                       outline_color => 'black');

#  $box->lower_to_bottom;
  #$box->signal_connect (event => sub {
  #        my ($item, $event) = @_;
  #        warn "event ".$event->type."\n";
  #});

  my $points = [$x+$Geometry::Scale*5,$y+$Geometry::Scale*9,
		$x+$Geometry::Scale*10,$y+$Geometry::Scale*9];

  my $line = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
					points => $points,
					width_units => 1.0,
					cap_style => 'projecting',
					fill_color => 'red',
					join_style => 'miter');

  return $box;
}

sub draw_X_1 {

  my $x = $_[0];
  my $y = $_[1];


  my $box = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Rect',
                                       x1 => $x+$Geometry::Scale*1, y1 => $y+$Geometry::Scale*1,
                                       x2 => $x+$Geometry::Scale*5, y2 => $y+$Geometry::Scale*9,
                                       fill_color => 'blue',
                                       outline_color => 'black');

  my $points = [$x+$Geometry::Scale*5,$y+$Geometry::Scale*1,
		$x+$Geometry::Scale*10,$y+$Geometry::Scale*1];

  my $line = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
					points => $points,
					width_units => 1.0,
					cap_style => 'projecting',
					fill_color => 'blue',
					join_style => 'miter');


  return $box;
}

sub draw_0_0 {

  my $x = $_[0];
  my $y = $_[1];

  my $points = [$x,$y+$Geometry::Scale*9,$x+$Geometry::Scale*10,$y+$Geometry::Scale*9];

  my $line = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
					points => $points,
					width_units => 1.0,
					cap_style => 'projecting',
					fill_color => 'blue',
					join_style => 'miter');


  return $box;
}

sub draw_1_1 {

  my $x = $_[0];
  my $y = $_[1];

  my $points = [$x,$y+$Geometry::Scale*1,$x+$Geometry::Scale*10,$y+$Geometry::Scale*1];

  my $line = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
					points => $points,
					width_units => 1.0,
					cap_style => 'projecting',
					fill_color => 'blue',
					join_style => 'miter');


  return $box;
}

sub draw_0_1 {

  my $x = $_[0];
  my $y = $_[1];

  my $points = [$x,   $y+$Geometry::Scale*9,
		$x+$Geometry::Scale*5,$y+$Geometry::Scale*9,
		$x+$Geometry::Scale*5,$y+$Geometry::Scale*1,
		$x+$Geometry::Scale*10,$y+$Geometry::Scale*1];

  my $line = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
					points => $points,
					width_units => 1.0,
					cap_style => 'projecting',
					fill_color => 'blue',
					join_style => 'miter');


  return $box;
}

sub draw_1_0 {

  my $x = $_[0];
  my $y = $_[1];

  my $points = [$x,   $y+$Geometry::Scale*1,
		$x+$Geometry::Scale*5,$y+$Geometry::Scale*1,
		$x+$Geometry::Scale*5,$y+$Geometry::Scale*9,
		$x+$Geometry::Scale*10,$y+$Geometry::Scale*9];

  my $line = Gnome2::Canvas::Item->new ($Widgets::LogicAnalyzerCanvas->root, 'Gnome2::Canvas::Line',
					points => $points,
					width_units => 1.0,
					cap_style => 'projecting',
					fill_color => 'blue',
					join_style => 'miter');


  return $box;
}
1

