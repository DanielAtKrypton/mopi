#!/usr/bin/perl

$string = @ARGV[0];
$pattern = @ARGV[1];
$modifier = @ARGV[2];

# print "pattern is:$pattern.\n";
# print "string is:$string.\n";

$string =~ m/(?$modifier)$pattern/;
# print "Matched: $&\n";
# print "Before: $`\n";
# print "After: $'\n";
print "${&}\n${`}\n${'}";