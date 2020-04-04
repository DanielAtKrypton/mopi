#!/usr/bin/perl

$string = @ARGV[0];
$pattern = @ARGV[1];

# $pattern = 'C:\Users\Daniel\Workspaces\Matlab\mopi\fexDownload.sh';
# $patttern  ='^[A-Z](?![A-Z]:\\)'

$pattern = qr/($pattern)/;

# $match = ($string =~ /$pattern/g);
# if ($match)  {
#    print $match;
# }


$string =~ /$pattern/g;
# print "Before: $`\n";
# print "Matched: $&\n";
# print "After: $'\n";

print "$&";