#!/usr/bin/perl -w

#
# multigate uptime 
# (C) 2000,2001 Wieger Opmeer , Casper Joost Eyckelhof
#

#
# Imports and global vars
#

use strict;
use vars qw( $dbh $password );
use FileHandle;
use DBI;
use lib '../../lib';
use Multigate::Config qw( getconf readconfig );
use Multigate::Users;
use Date::Calc qw( Language Decode_Language Delta_DHMS Add_Delta_YMD Today Today_and_Now );

#
# ---------------------------------------------------------
# main
#

my $fh = new FileHandle;

readconfig("../../multi.conf");    #allowed this way?
my $password = getconf('db_passwd');
my $db_user  = getconf('db_user');
my $database = getconf('db_name');
my $dbh = DBI->connect( 'DBI:mysql:' . $database,
    $db_user, $password, { RaiseError => 0, AutoCommit => 1 } );

if ( !defined $dbh ) {
    print STDERR DBI::errstr;
    exit 0;
}

my $arg = $ARGV[0];
$arg =~ s/\s+$//;    #no trailing spaces

my $user = $ENV{'MULTI_REALUSER'};

if ( ( !defined $arg ) || ( $arg eq "" ) ) {
    $arg = $user;
}

#some smart check?

douptime($arg);
exit 0;

sub douptime {
    my $nick = shift;

    my $user = aliastouser($arg);

    my @row = $dbh->selectrow_array( <<'EOT', {}, $user );
SELECT
  birthday, birthtime
FROM
  user
WHERE
  username LIKE ?
EOT

    my ( $bdt, $btm ) = @row;

    unless ( @row and $bdt ) {
        print "Geen verjaardag gevonden voor '$user'.\n";
        return;
    }

    $bdt =~ s/(\d\d\d\d)-(\d\d)-(\d\d)/$3-$2-$1/;
    my ( $by, $bm, $bd ) = ( $1, $2, $3 );

    $btm = '00:00:00' unless $btm;

    my ( $bh, $bmin, $bs ) = $btm =~ /(\d\d):(\d\d):(\d\d)/;

    my ( $ty, $tm, $td, $th, $tmin, $ts ) = Today_and_Now();

    my $Dy = $ty - $by;

    my ( $Dd, $Dh, $Dm, $Ds ) = Delta_DHMS( $ty, $bm, $bd, $bh, $bmin, $bs, $ty, $tm, $td, $th, $tmin, $ts );
    if ( ( $Dd < 0 )
        || ( ( $Dd == 0 ) && ( $Dh < 0 ) )
        || ( ( $Dd == 0 ) && ( $Dh == 0 ) && ( $Dm < 0 ) )
        || ( ( $Dd == 0 ) && ( $Dh == 0 ) && ( $Dm == 0 ) && ( $Ds < 0 ) ) )
    {

        #if ( $Dd <= 0 ) {
        $Dy--;
        ( $Dd, $Dh, $Dm, $Ds ) = Delta_DHMS( $ty - 1, $bm, $bd, $bh, $bmin, $bs, $ty, $tm, $td, $th, $tmin, $ts );
    }

    print "$user system boot $bdt $btm, uptime $Dy years, $Dd days, $Dh hours, $Dm minutes, $Ds seconds.\n";

    return;
}

#
# Try to resolve an alias into a user; return alias if it fails
#
sub aliastouser {
    my $alias = shift;
    return '' unless $alias;
    my $res = $dbh->selectrow_array( <<'EOT', {}, $alias );
SELECT
  username
FROM
  alias
WHERE
  alias = ?
EOT
    return $alias unless defined $res;
    return $res;
}

if ( defined $dbh ) {
    $dbh->disconnect;
}

1;    # You never know...
