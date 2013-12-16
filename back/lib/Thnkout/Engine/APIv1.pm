package Thnkout::Engine::APIv1;

use utf8;
use Moo;
use Data::Dumper;
use Thnkout::Service::Topic;
use JSON;
use Log::Minimal;

sub get_topic {
    my ($self, $context) = @_;
    my $topic_id = $context->route->{topic_id};
    print Dumper $topic_id;
    #print Dumper $context;
    my $topic = Thnkout::Service::Topic->find_topic($context->db, $topic_id);
    print Dumper $topic;
    $context->json($topic);
}

sub post_topic {
    my ($self, $context) = @_;
    # POST is in body
    my $data = decode_json $context->request->content;
    debugf $data->{topic} . "is POST'ed";
    my $oid = Thnkout::Service::Topic->create_topic($context->db, $data->{topic});
    my $id = $oid->to_string;
    debugf "$id is created for the new topic";
    $context->json({id => $id});
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
