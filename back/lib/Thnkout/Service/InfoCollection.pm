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

    #my $cursor = $db->mongodbh('theme')->find({_id => MongoDB::OID->new(value => $theme_id)}); 
    #my @theme = $cursor->all;
    #print Dumper $theme[0];
    #if (defined $theme[0]){
    #    my $row =$db->mongodbh('theme')->update(
    #        {_id => MongoDB::OID->new(value => $theme_id)}, 
    #        #{$theme[0] => { 'information_collection' => $data }}
    #        {'$set' => { 'information_collection' => $data }}
    #    );
    #    return $row;
    #return $db->mongodbh('theme')->insert({"name" => $theme});
}    


1;
