package Thnkout::Engine::APIv1;

use utf8;
use Moo;
use Data::Dumper;
use Thnkout::Service::Theme;
use Thnkout::Service::InfoCollection;
use JSON;
use Log::Minimal;

sub get_theme {
    my ($self, $context) = @_;
    my $theme_id = $context->route->{theme_id};
    debugf "Got $theme_id";
    my $theme = Thnkout::Service::Theme->find_theme_by_id($theme_id);
    $theme->{_id} = $theme->{_id}->to_string;
    $theme->{strategies} = { approaches => "" };
    $context->json($theme);
}

sub get_login_info {
    my ($self, $context) = @_;
    #print Dumper $Thnkout::model->mongodb;
}

sub post_theme {
    my ($self, $context) = @_;
    # POST is in body
    my $data = decode_json $context->request->content;
    debugf $data->{theme} . "is POST'ed";
    my $oid = Thnkout::Service::Theme->create_theme($context->db, $data->{theme});
    #my $id = $oid->to_string;
    debugf $oid->to_string . " is created for the new theme";
    $context->json({id => $oid->to_string });
}

sub post_collection {
    my ($self, $context) = @_;
    my $theme_id = $context->route->{theme_id};
    my $data = decode_json $context->request->content;
    my $oid = Thnkout::Service::InfoCollection->add_collection($context->db, $theme_id, $data);
    debugf $oid->to_string . " is created for the new theme";
    $context->json({id => $oid->to_string });
}

sub default {
    my ($self, $context) = @_;

    print Dumper $context;
    #$context->render();
    #$context->plain_text('this', 'is', 'test');
    $context->html('index.html', { name => 'shohei' });
    #$context->redirect("/index.html");

    #my $user = $c->user;
    #return $c->html('index.html') unless $user;

    #my $bookmarks = Intern::Bookmark::Service::Bookmark->find_bookmarks_by_user(
    #    $c->db,
    #    { user => $user },
    #);
    #Intern::Bookmark::Service::Bookmark->load_entry_info($c->db, $bookmarks);
    #$c->html('index.html', {
    #    bookmarks => $bookmarks,
    #});
}

1;
