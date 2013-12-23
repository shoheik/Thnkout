package Thnkout::Config::Route;

use strict;
use warnings;
use utf8;

use Router::Simple::Declare;

sub make_router {
    return router {
        connect '/' => {
            engine => 'Index',
            action => 'default',
        };

        connect '/api/v1/topic/:topic_id' => {
            engine => 'APIv1',
            action => 'get_topic',
        } => {method => 'GET' };

        connect '/api/v1/information-collection/:theme_id' => {
            engine => 'APIv1',
            action => 'post_collection',
        } => { method => "POST" };

        connect '/api/v1/topic' => {
            engine => 'APIv1',
            action => 'post_topic',
        } => { method => 'POST' };

        connect '/bookmark' => {
            engine => 'Bookmark',
            action => 'default',
        };

        connect '/bookmark/add' => {
            engine => 'Bookmark',
            action => 'add_get',
        } => { method => 'GET' };

        connect '/bookmark/add' => {
            engine => 'Bookmark',
            action => 'add_post',
        } => { method => 'POST' };

        connect '/bookmark/delete' => {
            engine => 'Bookmark',
            action => 'delete_get',
        } => { method => 'GET' };
        connect '/bookmark/delete' => {
            engine => 'Bookmark',
            action => 'delete_post',
        } => { method => 'POST' };

        # JS で API 叩く感じに
        connect '/bookmark_js' => {
            engine => 'BookmarkJS',
            action => 'default',
        };

        # API
        connect '/api/bookmarks' => {
            engine => 'API',
            action => 'bookmarks',
        };
        connect '/api/bookmark' => {
            engine => 'API',
            action => 'bookmark_post',
        } => { method => 'POST'};
    };
}

1;
