use strict;
use warnings;
use utf8;

use Data::Dumper;
use FindBin qw($Bin);
use lib "$Bin/../lib";

use Plack::Builder;

use Thnkout;
use Thnkout::Config;

my $app = Thnkout->as_psgi;
my $root = config->root;

builder {
    enable 'Static', path => sub { s!^/static/!! }, root => "../front/dist/";
    $app;
};

