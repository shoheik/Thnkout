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
    enable "Plack::Middleware::Session", store => 'File';
    enable 'Static', path => sub { s!^/static/!! }, root => "../front/dist/";
    mount '/' => $app;
    mount '/oauth' => builder {
        enable 'OAuth', 
            on_success => sub {
                my ( $self, $token ) = @_;
                # TODO Login processing here
                print Dumper $self;
                print Dumper $token;
                return $self->redirect("/static/index.html");

                #`return [  200 , [ 'Content-type' => 'text/html' ] , 'Signin!' ];
                #my $userinfo = Plack::Middleware::OAuth::UserInfo->new( config => $self->config , token => $token );
                #print Dumper $userinfo;
                #if( $token->is_provider('Twitter')  || $token->is_provider('GitHub') || $token->is_provider('Google') ) {
                #    my $info = $userinfo->ask( $token->provider );
                #    #return $self->to_yaml( $info );
                #}
                #return $self->render( 'Error' );
            },
 
            providers => 
            {
                'Twitter' => {
                    consumer_key     => 'XvOfjbB63wtxtf0IhfYw',
                    consumer_secret  => 'UHfl2y68mkDX1VIvINgI5sUSLNsVBbwTq0LPmKkc64',
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

