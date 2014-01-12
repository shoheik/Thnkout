package Thnkout::Config::Route;

use strict;
use warnings;
use utf8;

use Router::Simple::Declare;

sub make_router {
    return router {


        connect '/api/v1/theme/:theme_id' => {
             engine => 'APIv1',
             action => 'get_theme',
        } => {method => 'GET' };

        connect '/api/v1/themes/:user_id' => {
             engine => 'APIv1',
             action => 'get_themes',
        } => {method => 'GET' };

        connect '/api/v1/summary/:theme_id' => {
             engine => 'APIv1',
             action => 'get_summary',
        } => {method => 'GET' };

        connect '/api/v1/login-info' => {
            engine => 'APIv1',
            action => 'get_login_info',
        } => {method => 'GET' };

        connect '/api/v1/information-collection/:theme_id' => {
            engine => 'APIv1',
            action => 'post_collection',
        } => { method => "POST" };

        connect '/api/v1/theme' => {
            engine => 'APIv1',
            action => 'post_theme',
        } => { method => 'POST' };


    };
}

1;
