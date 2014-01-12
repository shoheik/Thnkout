package Thnkout::Context;

use utf8;
use Moo;
use Try::Tiny;
use Thnkout::Config;
use Thnkout::Request;
use Thnkout::Error;
use JSON::XS;
use Encode;

has env => (
    is => 'rw', 
    required => 1
);

has route => (
    is => 'ro',
    lazy => 1,
    builder => '_build_route'
);

has request => (
    is => 'ro',
    lazy => 1,
    builder => '_build_request'
);

has response => (
    is => 'rw',
    lazy => 1,
    builder => '_build_response'
);

has stash => (
    is => 'rw',
    default => sub { return +{} },
);

has db => (
    is => 'ro',
    lazy => 1,
    builder => '_build_db'
);

sub _build_route {
    my $self = shift;
    return Thnkout::Config->router->match($self->env);
}

sub _build_request {
    my $self = shift;
    return undef unless $self->env;
    return Thnkout::Request->new($self->env);
};

sub _build_response {
    my $self = shift;
    return $self->request->new_response(200);
};

sub render_file {
    my ($self, $file, $args) = @_;
    $args //= {};
    require Thnkout::View::Xslate;
    my $content = Thnkout::View::Xslate->render_file($file, {
        c => $self,
        %{ $self->stash },
        %$args
    });
    return $content;
}

sub html {
    my ($self, $file, $args) = @_;
    my $content = $self->render_file($file, $args);
    $self->response->code(200);
    $self->response->content_type('text/html; charset=utf-8');
    $self->response->content(Encode::encode_utf8 $content);
}

sub json {
    my ($self, $hash) = @_;
    require JSON::XS;
    my $json = JSON::XS->new;
    $json->utf8;
    # $json->pretty(1);
    $self->response->code(200);
    $self->response->content_type('application/json; charset=utf-8');
    $self->response->content($json->encode($hash));
}

sub plain_text {
    my ($self, @lines) = @_;
    $self->response->code(200);
    $self->response->content_type('text/plain; charset=utf-8');
    $self->response->content(join "\n", @lines);
}

sub redirect {
    my ($self, $url) = @_;
    $self->response->code(302);
    $self->response->header(Location => $url);
}

sub error {
    my ($self, $code, $message, %opts) = @_;
    Thnkout::Error->throw($code, $message, %opts);
}

sub get_user_in_session {
    my $self = shift;
    my $session = Plack::Session->new($self->env);
    my $logged_in = $session->get('logged_in');
    if(defined $logged_in && $logged_in == 1){
        my $id = $session->get('id');
        my $screen_name = $session->get('screen_name');
        return { id => $id, screen_name => $screen_name };
    }else{
        return undef;
    }
}


# Utility
#sub user {
#    my ($self) = @_;
#    return $self->{user} if $self->{user};
#
#    my $user_name = $self->req->env->{'hatena.user'} or return '';
#    my $user = Intern::Bookmark::Service::User->find_user_by_name($self->db, {
#        name => $user_name,
#    });
#    $user //= Intern::Bookmark::Service::User->create($self->db, {
#        name => $user_name,
#    });
#
#    return $self->{user} = $user;
#}


1;
