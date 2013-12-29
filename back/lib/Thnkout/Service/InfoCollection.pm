package Thnkout::Service::InfoCollection;

use utf8;
use Moo;
use Carp;
use DateTime;
use Data::Dumper;
use Log::Minimal;

sub add_collection {
    my ($self, $theme_id, $data ) = @_;
    print Dumper $data;
    my $row = $Thnkout::model->get_theme_by_id($theme_id);
    if (defined $row){
        debugf "theme_id:$theme_id exists in DB. Updating..";
        return { result => $Thnkout::model->update_theme($theme_id, $data) };
    }else{
        debugf $theme_id . " is not in the database";
    }
}    


1;
