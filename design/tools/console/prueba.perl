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

my $InputLine;

############
### MAIN ###
############

my $prueba = "Hola";
$buff = chr(10) . chr(11);

print $buff;

#$buff =~ s/(.)/sprintf("%x",ord($1))/eg;

#print $prueba . ord($buff) . "\n";

# initialize a string 
my $str = "Hello World!";

# split the string into an array of characters
my @array = split //,$buff;

# converts the elements of the array into their
# equivalent ASCII codes
@array = map(ord, @array);

# print the array with spaces between elements
print "@array\n";
# it outputs: 72 101 108 108 111 32 87 111 114 108 100 33
