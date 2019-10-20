#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use POSIX;

my $IN = $ARGV[0];

my $stats    = {};
my $authors  = {};
my $total_pr = 0;

open(my $F, "<", $IN) or die "Error open file $IN: $!\n";
while (my $row = <$F>) {
    chomp $row;
    my ($pr_id, undef, $author, undef) = split /\s/, $row, 4;
    $stats->{author_name_of($author)}++;
    $authors->{author_name_of($author)} = 1;
    $total_pr++;
}
close $F;

my $max_length = max_length($authors);
#print get_line();
#print "Hacktoberfest 2019 Contributions by Perl Weekly Challenge Team Members\n";
print sprintf("[Total Pull Request: %d][Total Members: %d] Last updated at %s\n", $total_pr, scalar(keys %$authors), current_time());
#print get_line();
my $json  = '';
my $index = 1;
foreach my $author (sort { $stats->{$b} <=> $stats->{$a} } sort keys %$stats) {
    #print sprintf("%-". $max_length . "s: %d\n", $author, $stats->{$author});
    $json .= sprintf("\t    ['%2d: %s', %d],\n", $index++, $author, $stats->{$author});
}
#print get_line();

print $json;

sub current_time {
    return strftime "%Y-%m-%d %H:%M:%S", gmtime time;
}

sub get_line {
    return "----------------------------------------------------------------------\n";
}

sub max_length {
    my ($authors) = @_;

    my $length = 0;
    foreach my $author (keys %$authors) {
        if (length($author) >= $length) {
            $length = length($author);
        }
    }

    return $length;
}

sub author_name_of {
    my ($author_id) =@_;

    my $name_map = {
        'k-mx'                => 'Maxim Kolodyazhny',
        'izifresh'            => 'Izifresh',
        '4RandR'              => 'Vyacheslav Volgarev',
        'R59'                 => 'Tester R59',
        'jaldhar'             => 'Jaldhar H. Vyas',
        'Doomtrain14'         => 'Yet Ebreo',
        'ndelucca'            => 'Nazareno Delucca',
        'Scimon'              => 'Scimon Proctor',
        'bagheera-sands'      => 'James Smith',
        "mark-senn"           => "Mark Senn",
        'threadless-screw'    => 'Ozzy',
        'jacoby'              => 'Dave Jacoby',
        'jmaslak'             => 'Joelle Maslak',
        'kolcon'              => 'Lubos Kolouch',
        'choroba'             => 'E. Choroba',
        'oWnOIzRi'            => 'Steven Wilson',
        'Firedrake'           => 'Roger Bell_West',
        'Prajithp'            => 'Prajith P',
        'andrezgz'            => 'Andrezgz',
        'kyzn'                => 'Kivanc Yazan',
        'tagg'                => 'Lars Thegler',
        'mienaikage'          => 'Daniel Mita',
        'davorg'              => 'Dave Cross',
        'duanepowell'         => 'Duane Powell',
        'rage311'             => 'Rage311',
        'simbabque'           => 'Julien Fiegehenn',
        'rabbiveesh'          => 'Veesh Goldman',
        'seaker'              => 'Feng Chang',
        'adamcrussell'        => 'Adam Russell',
        'dcw803'              => 'Duncan C. White',
        'holli-holzer'        => 'Markus Holzer',
        'TJLanger'            => 'Trenton Langer',
        'PerlMonk-Athanasius' => 'Athanasius',
        'noudald'             => 'Noud',
        'drclaw1394'          => 'Ruben Westerberg',
    };

    (exists $name_map->{$author_id} && return $name_map->{$author_id})
    or die "Missing name for author [$author_id]\n";
}
