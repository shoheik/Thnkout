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
    my ($self, $theme_name) = @_;
    my $user = "anonymous";
    #my $datatime = 'xx';
    return $Thnkout::model->create_theme({"name" => $theme_name, "creator" => $user });
    #return $db->mongodbh('theme')->insert({"name" => $theme});
}    

1;
