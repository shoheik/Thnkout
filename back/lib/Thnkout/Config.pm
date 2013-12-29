package Thnkout::Config;

use strict;
use warnings;
use utf8;

use Thnkout::Config::Route;

use Config::ENV 'THNKOUT_ENV', export => 'config';
use Path::Class qw(file);

my $Router = Thnkout::Config::Route->make_router;
my $Root = file(__FILE__)->dir->parent->parent->absolute;

sub router { $Router }
sub root { $Root }

common {
};

$ENV{SERVER_PORT} ||= 3000;
config default => {
    origin => "http://localhost:$ENV{SERVER_PORT}",
};

config production => {
};

config local => {
    parent('default'),
    db => {
        intern_bookmark => {
            user     => 'intern',
            password => 'intern',
            dsn      => 'dbi:mysql:dbname=intern_bookmark;host=localhost',
        },
    },
    db_timezone => 'UTC',
};

config test => {
    parent('default'),

    db => {
        intern_bookmark => {
            user     => 'intern',
            password => 'intern',
            dsn      => 'dbi:mysql:dbname=intern_bookmark_test;host=localhost',
        },
        thnkout => {
            user     => 'thnkout',
            password => 'thnkout',
            dsn      => 'dbi:mysql:dbname=thnkout_test;host=localhost',
        },
    },
    db_timezone => 'UTC',

    'twitter' => {
           consumer_key     => 'XvOfjbB63wtxtf0IhfYw',
           consumer_secret  => 'UHfl2y68mkDX1VIvINgI5sUSLNsVBbwTq0LPmKkc64',
     },

};

1;
