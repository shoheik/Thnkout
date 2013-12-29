package Thnkout::DBI::Factory;

use Moo;
use utf8;
use Carp ();
use Scope::Container::DBI;
use Thnkout::Config;

use Teng;
use Teng::Schema::Loader;

use MongoDB;
use MongoDB::OID;

has mongodb => (
    is => 'ro',
    lazy => 1,
    builder => '_build_mongodb'
);

has teng => (
    is => 'ro',
    lazy => 1,
    builder => '_build_teng'
);

sub _build_mongodb{
    my $client = MongoDB::MongoClient->new;
    return $client->get_database('thnkout'); 
}

sub _build_teng{
    my $self = shift;
    return Teng::Schema::Loader->load(
        'dbh'       => $self->dbh('thnkout'),
        #'namespace' => 'MyApp::DB',
    );
}

sub dbconfig {
    my ($self, $name) = @_;
    my $dbconfig = config->param('db') // Carp::croak 'required db setting';
    return $dbconfig->{$name} // Carp::croak qq(db config for '$name' does not exist);
}

sub dbh {
    my ($self, $name) = @_;

    my $db_config = $self->dbconfig($name);
    my $user      = $db_config->{user} or Carp::croak qq(user for '$name' does not exist);
    my $password  = $db_config->{password} or Carp::croak qq(password for '$name' does not exist);
    my $dsn       = $db_config->{dsn} or Carp::croak qq(dsn for '$name' does not exist);

    my $dbh = Scope::Container::DBI->connect($dsn, $user, $password, {
        RootClass => 'Thnkout::DBI',
    });
    return $dbh;
}



sub query_builder {
    my ($self) = @_;

    require SQL::Maker;

    my $builder = SQL::Maker->new(
        driver => 'mysql',
    );
    return $builder;
}

sub mongodbh {
    my ($self, $name) = @_;
    return $self->mongodb->get_collection($name);
}

1;
