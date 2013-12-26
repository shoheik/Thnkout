package Thnkout::Service::InfoCollection;

use utf8;
use Moo;
use Carp;
use DateTime;
use Data::Dumper;
use Log::Minimal;

sub find_topic_by_id {
    my ($self, $db, $topic_id ) = @_;
    my $cursor = $db->mongodbh('topic')->find({_id => MongoDB::OID->new(value => $topic_id)});
    my @obj = $cursor->all;
    return $obj[0];
}

sub add_collection {
    my ($self, $db, $theme_id, $data ) = @_;
    print Dumper $theme_id;
    print Dumper $data;

    my $cursor = $db->mongodbh('topic')->find({_id => MongoDB::OID->new(value => $theme_id)}); 
    my @theme = $cursor->all;
    print Dumper $theme[0];
    if (defined $theme[0]){
        my $row =$db->mongodbh('topic')->update(
            {_id => MongoDB::OID->new(value => $theme_id)}, 
            #{$theme[0] => { 'information_collection' => $data }}
            {'$set' => { 'information_collection' => $data }}
        );
        return $row;
    }else{
        debugf $theme_id . " is not in the database";
    }
    #return $db->mongodbh('topic')->insert({"name" => $topic});
}    


#sub find_user_by_name {
#    my ($class, $db, $args) = @_;
#    my $name = $args->{name} // croak 'name required';
#    my $user = $db->dbh('intern_bookmark')->select_row_as(q[
#        SELECT * FROM user
#          WHERE name = :name
#    ], +{
#        name => $name
#    }, 'Thnkout::Model::User');
#
#    $user;
#}
#
#sub find_users_by_user_ids {
#    my ($class, $db, $args) = @_;
#    my $user_ids = $args->{user_ids} // croak 'user_ids required';
#
#    return $db->dbh('intern_bookmark')->select_all_as(q[
#        SELECT * FROM user
#          WHERE user_id IN (:user_ids)
#    ], +{
#        user_ids => $user_ids,
#    }, 'Thnkout::Model::User');
#}
#
#sub create {
#    my ($class, $db, $args) = @_;
#
#    my $name = $args->{name} // croak 'name required';
#
#    $db->dbh('intern_bookmark')->query(q[
#        INSERT INTO user
#          SET name  = :name,
#            created = :created
#    ], {
#        name     => $name,
#        created => DateTime->now,
#    });
#
#    return $class->find_user_by_name($db, {
#        name => $name,
#    });
#}

1;
