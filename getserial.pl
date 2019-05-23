#!/usr/bin/perl

use strict;
use LWP::Simple;
use LWP::UserAgent;
use Mojo::DOM;

my $inputfile  = $ARGV[0];

my ($url,$response,$html);
#my $outputfile = "result.txt";
my $outputfile = $inputfile.".out";
open (DATA, $inputfile) or die "Can't open $inputfile \n";
open OUTPUT, ">>".$outputfile or die "Could not open '$outputfile'\n";
foreach my $serviceTag (<DATA>)
{
   chomp $serviceTag;
#   print "\n$serviceTag\n";
#   print OUTPUT $serviceTag."\t";
   ##### Allow Cookies
   my $browser = LWP::UserAgent->new;
   $browser->cookie_jar({});
   $browser->cookie_jar( HTTP::Cookies->new(
      'file' => 'cookies.lwp',  # where to read/write cookies
      'autosave' => 0           # do not save it to disk when done
   ));

   # declare agent as mozilla, not perl LWP
   $browser->agent("Mozilla/8.0");
    #    
   my $urlPartA = "http://www.dell.com/support/home/us/en/19/product-support/servicetag/";
    #   configuration
   my $urlPartB = "/configuration";
   my $firstURL = join('', $urlPartA,$serviceTag,$urlPartB);
   #print "\nURL = $firstURL";

   $url = URI->new("$firstURL");
   $response = $browser->get( $url );
   $html = $response->content;
   #print "\nAnswer:\n$html\n\n";

   my @values;
   my $dom = Mojo::DOM->new;
   $dom->parse($html);
   my $skip;
   for my $dd ($dom->find('div.col-lg-4.col-md-4.col-sm-3.col-xs-6')->each) {
    push(@values, $dd->text) if $skip++;
    #print $dd->text, "\n" if $skip++;
   }
    #print $values[1]."\n";
    if ( $values[1] =~ m/^(\d{1,2})\/(\d{1,2})\/(\d{4})$/ )

    {   # format date better for Excel
        #print OUTPUT $values[1]."\n";
        #print OUTPUT "$3-$1-$2\n";
    }

    print $serviceTag.",".$values[1]."\n";
    print OUTPUT $serviceTag.",".$values[1]."\n";
    #print "$3-$1-$2\n";
}


close OUTPUT or die $!;
