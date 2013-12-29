package Thnkout::Service::User;

use strict;
use warnings;
use utf8;

use Carp;
use DateTime;
use Data::Dumper;
use Plack::Session;
use Net::Twitter::Lite::WithAPIv1_1;
use Thnkout::Config;
use Log::Minimal;

sub handle_user_info {
    my ($self, $env, $token) = @_;

    # Twitter Sigin handling 
    if($token->is_provider('Twitter')){
        my $nt = Net::Twitter::Lite::WithAPIv1_1->new(
            consumer_key        => config->param('twitter')->{consumer_key},
            consumer_secret     => config->param('twitter')->{consumer_secret},
            access_token        => $token->{params}->{access_token},
            access_token_secret => $token->{params}->{access_token_secret},
        );
        my $result;
        eval{
            $result = $nt->show_user({user_id => $token->{params}->{extra}->{user_id}});
            debugf(Dumper $result);
        };
        if ( my $err = $@ ) {
             debugf $err;
        }


        if (defined $result){
            my $user = $Thnkout::model->get_twitter_user($token->{params}->{extra}->{user_id});
            if (defined $user){
                # update if the attribute is different
            }else{
                debugf "Insert user as new record";
                $user = $Thnkout::model->add_twitter_user({
                    twitter_id => $token->{params}->{extra}->{user_id},
                    image_url => $result->{profile_image_url},
                    lang => $result->{lang},
                    screen_name => $result->{screen_name},
                });
            }
            #store the login info to session
            my $session = Plack::Session->new($env);
            $session->set('logged_in', 1);
            $session->set('id', $user->{id});
        }
    }
}

sub get_user_info {
    my ($self, $user_id) = @_;
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
