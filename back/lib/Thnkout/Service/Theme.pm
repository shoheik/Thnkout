package Thnkout::Service::Theme;

use utf8;
use Moo;
use Carp;
use DateTime;
use Data::Dumper;

sub find_theme_by_id {
    my ($self, $theme_id ) = @_;
    return $Thnkout::model->get_theme_by_id($theme_id);
}

sub create_theme {
    my ($self, $db, $theme) = @_;
    return $db->mongodbh('theme')->insert({"name" => $theme});
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
