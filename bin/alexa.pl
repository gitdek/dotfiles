#!/usr/bin/perl

use 5.008001;
use strict;
use warnings;
use XML::Simple;
use LWP::UserAgent;

BEGIN {
    our $AUTHOR  = 'dek';
    our $VERSION = '0.0.1';
}

my %stats;

$stats{begin} = time();

system { $ARGV[0] } @ARGV;

warn q(

  █████╗ ██╗     ███████╗██╗  ██╗ █████╗
 ██╔══██╗██║     ██╔════╝╚██╗██╔╝██╔══██╗
 ███████║██║     █████╗   ╚███╔╝ ███████║
 ██╔══██║██║     ██╔══╝   ██╔██╗ ██╔══██║
 ██║  ██║███████╗███████╗██╔╝ ██╗██║  ██║
 ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝


);

printf "rank,site,description\n";

main(@ARGV);

$stats{elapsed} = ( time() - $stats{begin} );

print_statistics();

sub main {

    my $ua =
        LWP::UserAgent->new( agent =>
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.19 (KHTML, like Gecko) Ubuntu/10.10 Chromium/18.0.1025.151 Chrome/18.0.1025.151 Safari/535.19'
        );

    $stats{processed} = 0;
    $stats{failed}    = 0;
    $stats{success}   = 0;

    while ( defined( my $site = <> ) ) {

        chomp $site;

        next unless defined $site && length $site;

        $stats{processed}++;

        my $resp = $ua->get( 'http://data.alexa.com/data?cli=10&dat=s&url=' . $site );
        if ( $resp->is_success && $resp->content =~ /POPULARITY/g ) {

            my $content = XML::Simple::XMLin( $resp->content );
            my $url     = $content->{SD}->[1]->{POPULARITY}->{URL};
            chop($url) if substr( $url, -1 ) eq '/';
            my $desc = $content->{DMOZ}->{SITE}->{DESC} || '0';
            my $rank = $content->{SD}->[1]->{POPULARITY}->{TEXT};

            if ( defined $rank && defined $url && length $rank && length $url ) {
                printf "%s,%s,%.60s\n", $rank, $url, $desc;
                $stats{success}++;
            }
            else {
                warn "[!] Error parsing response buffer for \'$site\'\n";
                $stats{failed}++;
            }
        }
        else {
            warn "[!] Unable to get valid response for \'$site\'\n\tResponse code: "
                . $resp->status_line;
            $stats{failed}++;
        }

        undef $resp;

        sleep 1;
    }

    return 0;
} ## ---------- end sub main

sub print_statistics {

    return unless $stats{processed} > 0;

    warn "\n", "-" x 70, "\n\n";

    printf "\nprocessed: %3s  success: %3s  failed: %3s\n", $stats{processed}, $stats{success},
        $stats{failed};

    printf "time elapsed was %d second(s).\n", $stats{elapsed};

    return 0;

} ## ---------- end sub print_statistics

=pod


=head1 NAME

Alexa - Query alexa for rankings.


=head1 AUTHOR

dek E<lt>dek AT dek.codesE<gt>


=cut

