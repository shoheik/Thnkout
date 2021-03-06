use strict;
use warnings;
use utf8;

use Data::Dumper;
$Data::Dumper::Indent = 0;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Plack::Builder;
use Plack::App::File;
use Plack::Response;
use Log::Minimal;
use Thnkout;
use Thnkout::Config;
use Thnkout::Service::User;
use Thnkout::Model;

my $app = Thnkout->as_psgi;
my $root = config->root;

builder {
    enable "Plack::Middleware::Session", store => 'File';

    # static for Single Page Application (SAP)
    enable 'DirIndex', dir_index => 'index.html';
    enable 
        'Static', 
        path => qr{^/index.html$|^/scripts|^/assets|^/styles|^/bower_components|^/views|^/404.html$|^/favicon.ico$|^/robot.txt$}, 
        root => "../front/dist/";
    mount '/' => $app;

    # handle logout
    mount '/logout' => sub {
        my $env = shift;
        Thnkout::Service::User->handle_logout($env);
        my $res = Plack::Response->new; 
        $res->redirect("/");
        return $res->finalize;
    };

    mount '/oauth' => builder {
        enable 'OAuth', 
            on_success => sub {
                my ( $self, $token ) = @_;
                debugf(Dumper $token);
                debugf(Dumper $self);
                Thnkout::Service::User->handle_login($self->{env}, $token);
                return $self->redirect("/");
                #return $self->render( 'Error' );
            },
 
            providers => 
            {
                'Twitter' => {
                    consumer_key     => config->param('twitter')->{consumer_key},
                    consumer_secret  => config->param('twitter')->{consumer_secret}
                },
                #'Facebook' => {
                #    client_id     => '',
                #    client_secret => '',
                #    scope     => 'email,read_stream',
                #},
                #'Google' =>  { 
                #    client_id     => '',
                #    client_secret => '',
                #    scope         => 'https://www.google.com/m8/feeds/'
                #},
                #'GitHub' => {
                #    client_id => '',
                #    client_secret => '',
                #    scope => 'user,public_repo'
                #},
            };
    };
};

