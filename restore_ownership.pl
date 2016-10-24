#!/usr/bin/perl
use strict;
use English;
use vars qw ($opt_h);
use Getopt::Std;

# Constants... make sure you adjust these to the proper columns, given your ls output
use constant {
        COL_OWNER               =>      2,      # column number (zero-based) of the owner
        COL_GROUP               =>      3,      # column number (zero-based) of the group
        COL_PATHNAME    =>      8,     # column number (zero-based) of the path name
# example:

#   0        1  2     3    4   5  6    7        8
#-rw-r--r--  1 user  user  15 Apr 21 09:30 /tmp/foo/bar

# so user is #2, group is #3, and path is #8

};


my      $usage;
my      $line;
my      $ownerID;
my      $groupID;
my      @fields;

$usage  = "usage: $0 [-h]\n";
$usage .= "    where h Provides this help information\n";
$usage .= "Type 'perldoc $0' for more information.\n";

#
# Process any command line options...
#
getopts ('h');  # no shifts of @ARGV before this!

die $usage if defined ($opt_h);         # help info?

$ENV{SHELL} = "/bin/bash";      # make sure that `...` and system() commands execute consistently

while (defined ($line = <STDIN>)) {
   chomp ($line);
   @fields = split (/\s+/, $line, COL_PATHNAME + 1);
   $fields[COL_PATHNAME] =~ s/ -> .*//;    # separate symbolic links from their target
   $fields[COL_PATHNAME] =~ s/\\ / /;              # fix escaped spaces in pathnames
   print "Path: $fields[COL_PATHNAME] ";
   if (-e "$fields[COL_PATHNAME]") {
      $ownerID = $fields[COL_OWNER] =~ /[a-z]/i ? getpwnam ($fields[COL_OWNER]) : $fields[COL_OWNER];
      $groupID = $fields[COL_GROUP] =~ /[a-z]/i ? getgrnam ($fields[COL_GROUP]) : $fields[COL_GROUP];
      if (defined ($ownerID) && defined ($groupID)) {
         print "Changing OWNER: $fields[COL_OWNER] GROUP: $fields[COL_GROUP]\n";
         chown ($ownerID, $groupID, "$fields[COL_PATHNAME]");
      }

      else {
         $ownerID = defined ($ownerID) ? $ownerID : 'unknown';
         $groupID = defined ($groupID) ? $groupID : 'unknown';
         print ">>> ERR OWNER=$ownerID, GROUP=$groupID <<<\n";
      }
   }
   else {
      print ">>> ERR Can't find the directory/file!  <<<\n";
   }
}
