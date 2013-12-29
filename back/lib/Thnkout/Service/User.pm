package Thnkout::Service::User;

use strict;
use warnings;
use utf8;

use Carp;
use DateTime;
use Data::Dumper;
use Net::Twitter::Lite::WithAPIv1_1;
use Thnkout::Config;
use Log::Minimal;

sub handle_user_info {
    my ($token) = @_;

    # Twitter Sigin handling 
    if($token->is_provider('Twitter')){
        my $nt = Net::Twitter::Lite::WithAPIv1_1->new(
            consumer_key        => config->param('twitter')->{consumer_key},
            consumer_secret     => config->param('twitter')->{consumer_secret},
            access_token        => $token->{params}->{access_token},
            access_token_secret => $token->{params}->{access_token_secret},
        );
        eval{
            my $result = $nt->show_user({user_id => $token->{params}->{extra}->{user_id}});
            debugf(Dumper $result);
            #$db->dbh('thnkout')->
            #$result->{profile_image_url};
            #$token->{params}->{extra}->{user_id} #id
            #$result->{screen_name}
            #$result->{name}
            #$result->{lang} # ja
            #$result->{location}
            #$result->{timezone}
        };
        if ( my $err = $@ ) {
             debugf $err;
        }
    }
}

sub find_user_by_name {
    my ($class, $db, $args) = @_;
    my $name = $args->{name} // croak 'name required';
    my $user = $db->dbh('intern_bookmark')->select_row_as(q[
        SELECT * FROM user
          WHERE name = :name
    ], +{
        name => $name
    }, 'Thnkout::Model::User');

    $user;
}

sub find_users_by_user_ids {
    my ($class, $db, $args) = @_;
    my $user_ids = $args->{user_ids} // croak 'user_ids required';

    return $db->dbh('intern_bookmark')->select_all_as(q[
        SELECT * FROM user
          WHERE user_id IN (:user_ids)
    ], +{
        user_ids => $user_ids,
    }, 'Thnkout::Model::User');
}

sub create {
    my ($class, $db, $args) = @_;

    my $name = $args->{name} // croak 'name required';

    $db->dbh('intern_bookmark')->query(q[
        INSERT INTO user
          SET name  = :name,
            created = :created
    ], {
        name     => $name,
        created => DateTime->now,
    });

    return $class->find_user_by_name($db, {
        name => $name,
    });
}

1;
