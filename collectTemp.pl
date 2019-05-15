#!/usr/bin/perl
use lib qw( /home/dalton/Desktop/build/rrdtool-1.7.1/bindings/perl-piped ../bindings/perl-piped );
use RRDs;
use strict; 
use warnings;

my $counter=0;
my $start;
my $end;

$start = time;
print "start: ",$start, "\n";

while(1){
    #obtain CPU's Core 0 temperature
    my $output = `sensors | grep "Core 0"`;
    my $front = index($output, '+')+1;
    my $back = index($output, '°');
    my $temp = substr $output, $front, $back-$front;

    print "$counter:\t Sending ";print $temp;print " C° to Database\n";
    $counter = $counter + 1;

    #store in database and update xml for debugging
    RRDs::update("temp.rrd", "-t", "temp", "N:$temp");
    #RRDs::dump("temp.rrd", "xml.xml");
    $end = time;
    sleep 30 - time % 30;

}

#RRDs::graph("out.png", "-s", "$start", "-e", "$end", "DEF:temp=temp.rrd:temp:AVERAGE", "LINE1:temp#000000:data");

