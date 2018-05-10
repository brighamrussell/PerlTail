#!/usr/bin/perl
use warnings;
use strict;
use File::Tail;

### Scopes variables
my ($name, $file, $line, $aggregate, $str);
$aggregate = '/var/log/aggregate.log';
$name='/var/log/apache2/access.log';

### Opens destination log file for writing
open(my $fh, '>', $aggregate) or die "Could not open file '$aggregate' $!";

### Tails source file
$file=File::Tail->new(name=>$name, maxinterval=>8, adjustafter=>7);

### Assigns one line at a time from source file to #line
while (defined($line=$file->read)) {

$str = $line;
$str =~ /\s([2-5][0-5][0-9])\s/g;
my $liner = $1 . " => " . $line . "\n";
print $fh $liner;

}
close $fh;
