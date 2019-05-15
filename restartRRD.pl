#!/usr/bin/perl
use lib qw( /home/dalton/Desktop/build/rrdtool-1.7.1/bindings/perl-piped ../bindings/perl-piped );
use RRDs;
use strict; 
use warnings;

if($#ARGV==0){

    RRDs::create("$ARGV[0]",
		 "--step", "30",
		 "DS:temp:GAUGE:600:-20:100",
		 "RRA:AVERAGE:0.5:30s:1d",
		 "RRA:AVERAGE:0.5:210s:7d",
		 "RRA:AVERAGE:0.5:900s:30d",
		 "RRA:AVERAGE:0.5:10950s:365d"
    );

    
}
else{
    print "Expected 1 argument, got ", $#ARGV+1, "\n";
}


