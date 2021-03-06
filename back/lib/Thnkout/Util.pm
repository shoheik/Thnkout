package Thnkout::Util;

use Moo;
use utf8;

use Carp ();
use Sub::Name;
use DateTime;
use DateTime::Format::MySQL;
use Thnkout::Config;

sub datetime_from_db ($) {
    my $dt = DateTime::Format::MySQL->parse_datetime( shift );
    $dt->set_time_zone(config->param('db_timezone'));
    $dt->set_formatter( DateTime::Format::MySQL->new );
    $dt;
}

sub get_current_datetime {
    my $self = shift;
    my $dt = DateTime->now( time_zone=>'local' );
    return DateTime::Format::MySQL->format_datetime($dt);
}

1;
