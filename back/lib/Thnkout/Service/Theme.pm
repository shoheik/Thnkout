package Thnkout::Service::Theme;

use utf8;
use Moo;
use Carp;
use DateTime;
use Data::Dumper;
use Log::Minimal;

sub find_theme_by_id {
    my ($self, $theme_id ) = @_;
    return $Thnkout::model->get_theme_by_id($theme_id);
}

sub find_themes_by_user_id {
    my ($self, $user_id ) = @_;
    return $Thnkout::model->get_themes_by_user_id($user_id);
}

sub get_summary_markdown {
    my ($self, $theme_id ) = @_;
    my $theme = $Thnkout::model->get_theme_by_id($theme_id);

    # title is theme name
    my $markdown = '#' .  $theme->{name} . "\n";

    # for information collection
    $markdown .= $self->compose_info_collection($theme);

    debugf(Dumper $theme);
    return $markdown;
}

sub create_theme {
    my ($self, $theme_name) = @_;
    my $user = "anonymous";
    #my $datatime = 'xx';
    return $Thnkout::model->create_theme({"name" => $theme_name, "creator" => $user });
    #return $db->mongodbh('theme')->insert({"name" => $theme});
}    

sub compose_info_collection{
    my ($self, $theme) = @_;
    if (defined $theme->{information_collection}){
        my $markdown = "##情報収集\n";
        for my $source ( @{ $theme->{information_collection}->{sources} } ){
            $markdown .= "###" . $source->{sourceName} . "\n";
            for my $point ( @{ $source->{points} }){
                $markdown .= "* $point\n";
            }
        }
        return $markdown;
    } else {
        return "";
    }
}

1;
