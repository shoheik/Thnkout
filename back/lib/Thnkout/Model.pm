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
    my ($self, $name) = @_;
    my $db_config = $self->dbconfig($name);
    my $user      = $db_config->{user} or Carp::croak qq(user for '$name' does not exist);
    my $password  = $db_config->{password} or Carp::croak qq(password for '$name' does not exist);
    my $dsn       = $db_config->{dsn} or Carp::croak qq(dsn for '$name' does not exist);
    return Teng::Schema::Loader->load(
        connect_info => [ $dsn, $user, $password, {mysql_enable_utf8=>1} ],
        # namespace => 'xxx'
    );
}

sub BUILD {
    debugf "Loading Model...";
}


sub get_theme_by_id {
    my ($self, $theme_id ) = @_;
    print Dumper $theme_id;
    my $cursor = $self->mongodb->get_collection('theme')->find({_id => MongoDB::OID->new(value => $theme_id)});
    print Dumper $cursor;
    my @obj = $cursor->all;
    return $obj[0];
}

1;

