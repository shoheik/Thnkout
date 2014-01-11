package Thnkout::Model;

# This module should loaded when it's started and only once.
# Therefore, do not keep store the data in it except db connections
use Class::Singleton;
use Moo;
use utf8;
use Log::Minimal;
use Carp ();
use Data::Dumper;
use Teng;
use Teng::Schema::Loader;
use MongoDB;
use MongoDB::OID;

use Thnkout::Config;
use Thnkout::Util;

has mongodb => (
    is => 'ro',
    lazy => 1,
    builder => '_mongodb_builder',
);

has mysql => (
    is => 'ro',
    lazy => 1,
    builder => '_mysql_builder',
);

sub _mongodb_builder {
    my $client = MongoDB::MongoClient->new;
    return $client->get_database('thnkout');
}

sub dbconfig {
    my ($self, $name) = @_;
    my $dbconfig = config->param('db') // Carp::croak 'required db setting';
    return $dbconfig->{$name} // Carp::croak qq(db config for '$name' does not exist);
}

sub _mysql_builder {
    my $self = shift;
    my $db_config = $self->dbconfig('thnkout');
    my $user      = $db_config->{user} or Carp::croak qq(user for thnkout does not exist);
    my $password  = $db_config->{password} or Carp::croak qq(password for thnkout does not exist);
    my $dsn       = $db_config->{dsn} or Carp::croak qq(dsn for thnkout does not exist);
    return Teng::Schema::Loader->load(
        connect_info => [ $dsn, $user, $password, {mysql_enable_utf8=>1} ],
        namespace => 'Thnkout::DB'
    );
}

sub BUILD {
    debugf "Loading Model...";
}

sub get_theme_by_id {
    my ($self, $theme_id ) = @_;
    debugf "Getting theme by id:$theme_id";
    my $cursor = $self->mongodb->get_collection('theme')->find({_id => MongoDB::OID->new(value => $theme_id)});
    my @obj = $cursor->all;
    return $obj[0];
}

sub get_themes_by_user_id {
    my ($self, $user_id ) = @_;
    debugf "Getting theme by user_id:$user_id";
    my $cursor = $self->mongodb->get_collection('theme')->find({"creator" => $user_id});
    my @themes;
    while (my $obj = $cursor->next) {
        my $theme = {
            id => $obj->{_id}->to_string,
            name => $obj->{name},
        };
        push @themes, $theme;
    }
    debugf Dumper \@themes;
    return \@themes;
}

sub update_theme {
    my ($self, $theme_id, $data) = @_;

    my $result = $self->mongodb->get_collection('theme')->update(
        {_id => MongoDB::OID->new(value => $theme_id)}, 
        {'$set' => { 'information_collection' => $data }},
    );
    debugf("return value:" . $result->{ok} );
    return $result->{ok};
}

sub create_theme {
    my ($self, $theme_doc) = @_;
    debugf "Insert theme:" . Dumper($theme_doc);
    $self->mongodb->get_collection('theme')->insert($theme_doc);
}

sub get_twitter_user {
    my ($self, $twitter_id) = @_;
    my $row = $self->mysql->single('user', +{twitter_id => $twitter_id});
    return undef if (not defined $row);
    return $row->get_columns; 
}

sub get_user {
    my ($self, $user_id) = @_;
    my $row = $self->mysql->single('user', +{id => $user_id});
    return undef if (not defined $row);
    return $row->get_columns; 
}

sub add_twitter_user {
    my ($self, $data) = @_;
    my $created_at = Thnkout::Util::get_current_datetime(); 
    my $row = $self->mysql->insert(
        'user', 
        +{
            twitter_id => $data->{twitter_id},
            image_url => $data->{image_url},
            screen_name => $data->{screen_name},
            lang => $data->{lang},
            created_at => $created_at, 
        }
    );
    return undef if (not defined $row);
    return $row->get_columns;
}

1;

